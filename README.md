# vote

Vote App

## Getting Started

### Install Libraries

```sh
# Routing
flutter pub add go_router
# 또는
flutter pub add auto_route auto_route_generator build_runner

# State
flutter pub add flutter_bloc equatable

# Supabase
flutter pub add supabase
flutter pub add supabase_flutter   # 세션/깊은링크 관리 필요 시

# Model codegen
flutter pub add freezed_annotation json_annotation
flutter pub add --dev build_runner freezed json_serializable

# DI
flutter pub add get_it injectable
flutter pub add --dev injectable_generator

# Env
flutter pub add envied
flutter pub add --dev envied_generator
```

### Run Supabase In Local

```sh
supabase init
supabase start
```

### Generate Files

```sh
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```