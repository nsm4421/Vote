# Vote App - 데이터베이스 스키마 (Supabase/Postgres)

투표 생성, 옵션, 투표 기록을 실시간/감사 가능하게 관리하기 위한 기본 테이블 정의입니다.

## 규칙
- 모든 PK는 `uuid`(`gen_random_uuid()`).
- 시간 컬럼은 `timestamptz` + `now()` 기본값.
- 자식이 부모보다 오래 남지 않도록 필요한 곳에 `on delete cascade`.
- 인증된 사용자는 `auth.users`를 단일 소스로 사용.

## 테이블

### profiles
`auth.users`와 동기화되는 가벼운 프로필 정보.

| column       | type        | 제약 / 기본값                            | 비고                          |
| ------------ | ----------- | ---------------------------------------- | ----------------------------- |
| id           | uuid        | pk, references auth.users(id)            | auth 사용자 id와 동일         |
| display_name | text        | not null default ''                      | 노출 이름                     |
| avatar_url   | text        | nullable                                 | 선택적 아바타                 |
| created_at   | timestamptz | default now()                            |                               |
| updated_at   | timestamptz | default now()                            | 업데이트 트리거 권장          |

인덱스: `pk_profiles`.

### polls
폴 메타데이터 상위 테이블.

| column        | type        | 제약 / 기본값                                  | 비고                                   |
| ------------- | ----------- | ---------------------------------------------- | -------------------------------------- |
| id            | uuid        | pk                                             |                                        |
| owner_id      | uuid        | references profiles(id) on delete cascade      | 생성자                                 |
| title         | text        | not null                                       | 제목                                   |
| description   | text        | nullable                                       | 설명                                   |
| is_anonymous  | boolean     | not null default false                         | true 시 UI에서 투표자 식별 숨김        |
| allow_multi   | boolean     | not null default false                         | 여러 옵션 선택 허용                    |
| status        | text        | not null default 'draft'                       | draft/open/closed                      |
| opens_at      | timestamptz | nullable                                       | 예약 오픈                              |
| closes_at     | timestamptz | nullable                                       | 예약 종료                              |
| created_at    | timestamptz | default now()                                  |                                        |
| updated_at    | timestamptz | default now()                                  | 업데이트 트리거 권장                   |

인덱스: `pk_polls`, `idx_polls_owner_id`, `idx_polls_status`, `idx_polls_opens_closes_at`(예정/종료 필터링).

### poll_options
폴의 선택지.

| column     | type        | 제약 / 기본값                                        | 비고                 |
| ---------- | ----------- | ---------------------------------------------------- | -------------------- |
| id         | uuid        | pk                                                   |                      |
| poll_id    | uuid        | references polls(id) on delete cascade               | 소속 폴              |
| label      | text        | not null                                             | 옵션 텍스트          |
| sort_order | integer     | not null default 0                                   | UI 정렬용            |
| created_at | timestamptz | default now()                                        |                      |

인덱스: `pk_poll_options`, `idx_poll_options_poll_id_sort_order`(정렬용 복합).
제약: `(poll_id, label)` unique로 중복 옵션 방지.

### poll_votes
개별 투표 기록.

| column        | type        | 제약 / 기본값                                               | 비고                                                |
| ------------- | ----------- | ----------------------------------------------------------- | --------------------------------------------------- |
| id            | uuid        | pk                                                          |                                                     |
| poll_id       | uuid        | references polls(id) on delete cascade                      | 빠른 필터링을 위한 중복 저장                        |
| option_id     | uuid        | references poll_options(id) on delete cascade               |                                                     |
| voter_id      | uuid        | references profiles(id) on delete set null                  | 익명/게스트면 null                                  |
| session_id    | uuid        | nullable                                                    | 게스트 중복 방지용 클라이언트 세션 id                |
| created_at    | timestamptz | default now()                                               | 투표 시각                                           |
| ip_hash       | text        | nullable                                                    | 오남용 탐지용 해시(소금쳐서 저장)                   |

인덱스:
- `pk_poll_votes`
- `idx_poll_votes_poll_id`
- `idx_poll_votes_option_id`
- `idx_poll_votes_session_id` (partial unique에 활용)

제약:
- `(poll_id, voter_id)` unique where `voter_id` is not null (로그인 사용자는 폴당 한 세트).
- `(poll_id, session_id)` unique where `session_id` is not null (게스트 중복 방지).

### poll_invites (선택, 공유 코드/접근 제어)

| column        | type        | 제약 / 기본값                               | 비고                         |
| ------------- | ----------- | ------------------------------------------- | ---------------------------- |
| id            | uuid        | pk                                          |                              |
| poll_id       | uuid        | references polls(id) on delete cascade      |                              |
| code          | text        | not null unique                             | 초대/공유 코드               |
| expires_at    | timestamptz | nullable                                    | 만료일                       |
| max_uses      | integer     | nullable                                    | null = 무제한                |
| use_count     | integer     | not null default 0                          | 사용 시 증가                 |
| created_at    | timestamptz | default now()                               |                              |

인덱스: `pk_poll_invites`, `code` unique.

## Row-Level Security(RLS) 개요
- `profiles`: 본인 행만 select/update(`auth.uid() = id`).
- `polls`: 소유자는 select/update/delete; `status = 'open'` 또는 초대된 경우 공개 select.
- `poll_options`: poll 가시성에 맞춰 select; poll 미종료 시 소유자만 수정 가능.
- `poll_votes`: poll open 시 insert 허용; unique 제약으로 중복 방지; 볼 수 있는 poll에 한해 select.
- `poll_invites`: 소유자만 select/insert/update/delete.

`polls`, `poll_options`, `poll_votes`에 대해 realtime 구독을 걸어 라이브 결과를 갱신할 수 있습니다. 필요에 따라 컬럼(예: 옵션 이미지, 주관식 응답)을 추가하세요.
