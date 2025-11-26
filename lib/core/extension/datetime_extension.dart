extension DatetimeExtension on DateTime {
  String get yyyymmdd {
    final year = this.year.toString().padLeft(4);
    final month = this.month.toString().padLeft(2);
    final day = this.day.toString().padLeft(2);
    return '$year$month$day';
  }
}
