extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday => isSameDay(DateTime.now());
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));

  String toYmd({String separator = '-'}) {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$y$separator$m$separator$d';
  }

  String toHm({String separator = ':'}) {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h$separator$m';
  }

  String toYmdHm({String dateSeparator = '-', String timeSeparator = ':'}) {
    return '${toYmd(separator: dateSeparator)} ${toHm(separator: timeSeparator)}';
  }

  /// Simple relative string like "just now", "5m ago", "3h ago", "2d ago".
  String toAgoString({DateTime? now}) {
    final current = now ?? DateTime.now();
    final diff = current.difference(this);

    if (diff.isNegative || diff.inSeconds <= 5) return 'just now';
    if (diff.inMinutes < 1) return '${diff.inSeconds}s ago';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  DateTime addDays(int days) => add(Duration(days: days));
}
