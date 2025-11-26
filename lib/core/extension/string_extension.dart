extension StringExtension on String {
  bool get isBlank => trim().isEmpty;

  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String ellipsis(int maxLength, {String marker = '...'}) {
    if (length <= maxLength) return this;
    if (maxLength <= marker.length) return substring(0, maxLength);
    return substring(0, maxLength - marker.length) + marker;
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
  String orEmpty() => this ?? '';
}
