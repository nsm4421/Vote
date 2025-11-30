-- Vote App schema DDL + RLS (Supabase/Postgres)
-- 기반 문서: docs/schema/README.md

-- Extensions
create extension if not exists "pgcrypto" with schema extensions;

-- updated_at 갱신용 트리거 함수
create or replace function public.set_current_timestamp()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- profiles ---------------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

drop trigger if exists set_timestamp_profiles on public.profiles;
create trigger set_timestamp_profiles
before update on public.profiles
for each row execute function public.set_current_timestamp();

alter table public.profiles enable row level security;

create policy "profiles_select_self"
  on public.profiles
  for select
  using (auth.uid() = id or auth.role() = 'service_role');

create policy "profiles_insert_self"
  on public.profiles
  for insert
  with check (auth.uid() = id or auth.role() = 'service_role');

create policy "profiles_update_self"
  on public.profiles
  for update
  using (auth.uid() = id or auth.role() = 'service_role')
  with check (auth.uid() = id or auth.role() = 'service_role');

-- polls -------------------------------------------------------------------
create table if not exists public.polls (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  description text,
  is_anonymous boolean not null default false,
  allow_multi boolean not null default false,
  status text not null default 'draft' check (status in ('draft', 'open', 'closed')),
  opens_at timestamptz,
  closes_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

drop trigger if exists set_timestamp_polls on public.polls;
create trigger set_timestamp_polls
before update on public.polls
for each row execute function public.set_current_timestamp();

create index if not exists idx_polls_owner_id on public.polls (owner_id);
create index if not exists idx_polls_status on public.polls (status);
create index if not exists idx_polls_opens_closes_at on public.polls (opens_at, closes_at);

alter table public.polls enable row level security;

create policy "polls_select_open"
  on public.polls
  for select
  using (status = 'open' or auth.role() = 'service_role');

create policy "polls_select_owner"
  on public.polls
  for select
  using (owner_id = auth.uid() or auth.role() = 'service_role');

create policy "polls_insert_owner"
  on public.polls
  for insert
  with check (owner_id = auth.uid() or auth.role() = 'service_role');

create policy "polls_update_owner"
  on public.polls
  for update
  using (owner_id = auth.uid() or auth.role() = 'service_role')
  with check (owner_id = auth.uid() or auth.role() = 'service_role');

create policy "polls_delete_owner"
  on public.polls
  for delete
  using (owner_id = auth.uid() or auth.role() = 'service_role');

-- poll_options ------------------------------------------------------------
create table if not exists public.poll_options (
  id uuid primary key default gen_random_uuid(),
  poll_id uuid not null references public.polls(id) on delete cascade,
  label text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  constraint poll_options_poll_label_unique unique (poll_id, label)
);

create index if not exists idx_poll_options_poll_id_sort_order
  on public.poll_options (poll_id, sort_order);

alter table public.poll_options enable row level security;

create policy "poll_options_select_follow_poll_visibility"
  on public.poll_options
  for select
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_options.poll_id
        and (p.status = 'open' or p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );

create policy "poll_options_insert_owner_when_active"
  on public.poll_options
  for insert
  with check (
    exists (
      select 1
      from public.polls p
      where p.id = poll_options.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
        and p.status <> 'closed'
    )
  );

create policy "poll_options_update_owner_when_active"
  on public.poll_options
  for update
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_options.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
        and p.status <> 'closed'
    )
  )
  with check (
    exists (
      select 1
      from public.polls p
      where p.id = poll_options.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
        and p.status <> 'closed'
    )
  );

create policy "poll_options_delete_owner_when_active"
  on public.poll_options
  for delete
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_options.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
        and p.status <> 'closed'
    )
  );

-- poll_votes --------------------------------------------------------------
create table if not exists public.poll_votes (
  id uuid primary key default gen_random_uuid(),
  poll_id uuid not null references public.polls(id) on delete cascade,
  option_id uuid not null references public.poll_options(id) on delete cascade,
  voter_id uuid references public.profiles(id) on delete set null,
  session_id uuid,
  created_at timestamptz not null default now(),
  ip_hash text
);

create index if not exists idx_poll_votes_poll_id on public.poll_votes (poll_id);
create index if not exists idx_poll_votes_option_id on public.poll_votes (option_id);
create index if not exists idx_poll_votes_session_id on public.poll_votes (session_id);
create unique index if not exists uid_poll_votes_poll_voter
  on public.poll_votes (poll_id, voter_id)
  where voter_id is not null;
create unique index if not exists uid_poll_votes_poll_session
  on public.poll_votes (poll_id, session_id)
  where session_id is not null;

alter table public.poll_votes enable row level security;

create policy "poll_votes_select_follow_poll_visibility"
  on public.poll_votes
  for select
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_votes.poll_id
        and (p.status = 'open' or p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );

create policy "poll_votes_insert_when_open"
  on public.poll_votes
  for insert
  with check (
    exists (
      select 1
      from public.polls p
      where p.id = poll_votes.poll_id
        and p.status = 'open'
    )
    and (
      poll_votes.voter_id is null
      or poll_votes.voter_id = auth.uid()
      or auth.role() = 'service_role'
    )
  );

-- poll_invites ------------------------------------------------------------
create table if not exists public.poll_invites (
  id uuid primary key default gen_random_uuid(),
  poll_id uuid not null references public.polls(id) on delete cascade,
  code text not null unique,
  expires_at timestamptz,
  max_uses integer,
  use_count integer not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists idx_poll_invites_poll_id on public.poll_invites (poll_id);

alter table public.poll_invites enable row level security;

create policy "poll_invites_owner_access"
  on public.poll_invites
  for select
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_invites.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );

create policy "poll_invites_owner_insert"
  on public.poll_invites
  for insert
  with check (
    exists (
      select 1
      from public.polls p
      where p.id = poll_invites.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );

create policy "poll_invites_owner_update"
  on public.poll_invites
  for update
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_invites.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  )
  with check (
    exists (
      select 1
      from public.polls p
      where p.id = poll_invites.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );

create policy "poll_invites_owner_delete"
  on public.poll_invites
  for delete
  using (
    exists (
      select 1
      from public.polls p
      where p.id = poll_invites.poll_id
        and (p.owner_id = auth.uid() or auth.role() = 'service_role')
    )
  );
