# Extension Cheatsheet

빠르게 확인할 수 있도록 각 extension과 주요 메서드를 정리했습니다.

## BuildContextExtension (build_context_extension.dart)
- `screenSize`, `screenWidth`, `screenHeight`: MediaQuery 크기 헬퍼.
- `keyboardHeight`, `isKeyboardVisible`: 키보드 상태 확인.
- `safeTop`, `safeBottom`, `safeHeight`: SafeArea 고려 높이.
- `hideKeyboard()`: 포커스 해제.
- `l10n`: `AppLocalizations.of(context)`.
- `colorScheme`, `textTheme`: Theme shortcut.

## ThemeContextExtension (theme_extension.dart)
- `theme`, `colorScheme`, `textTheme`, `isDarkMode`: Theme 접근 헬퍼.

## ColorExtension (color_extension.dart)
- `fromHex(String)`: `#RRGGBB`/`RRGGBB`/`AARRGGBB` 문자열을 Color로 변환.
- `withOpacityPercent(int)`: 0~100 퍼센트 기반 투명도 적용.
- `withOpacityClamped(double)`: 0~1 사이로 클램프 후 투명도 적용.
- `toHex({leadingHashSign, includeAlpha})`: Hex 문자열 변환.
- `alphaComponent`/`redComponent`/`greenComponent`/`blueComponent`: 각 채널 Hex 2자리.

## DateTimeExtension (date_time_extension.dart)
- `isSameDay(DateTime)`, `isToday`, `isTomorrow`: 날짜 비교.
- `toYmd({separator})`, `toHm({separator})`, `toYmdHm(...)`: 포맷 헬퍼.
- `toAgoString({now})`: now 기준 상대 시간 문자열(초/분/시간/일).
- `addDays(int)`: 일수 더하기.

## DatetimeExtension (datetime_extension.dart)
- `yyyymmdd`: `YYYYMMDD` 포맷 문자열.

## DurationExtension (duration_extension.dart)
- `toMmSs()`: `mm:ss`.
- `toReadable()`: `45s`, `2h 5m`, `3d 2h` 등 사람친화 포맷.

## FutureExtension<T> (future_extension.dart)
- `ignoreError()`: 에러를 null로 무시.
- `withTimeoutOrNull(Duration)`: 타임아웃 시 null 반환.
- `delay(Duration)`: 지정 시간 지연 후 원본 future 반환.

## IterableExtension<T> (iterable_extension.dart)
- `firstWhereOrNull(test)`: 조건 첫 원소 또는 null.
- `chunked(int size)`: 고정 크기 리스트 묶음 생성.
- `sortedBy(keySelector)`: 키 기준 정렬한 새 리스트.

### IterableNumExtension
- `sum()`: 합계.
- `average()`: 평균(빈 경우 0).

### IterableDistinctExtension<T>
- `distinctBy(keySelector)`: 키 기준 중복 제거 리스트.

## StringExtension (string_extension.dart)
- `isBlank`: 공백 제거 후 빈 문자열 여부.
- `capitalize()`: 첫 글자만 대문자.
- `ellipsis(maxLength, {marker})`: 길이 초과 시 말줄임 적용.

### NullableStringExtension
- `isNullOrBlank`: null 혹은 공백 여부.
- `orEmpty()`: null을 빈 문자열로 대체.
