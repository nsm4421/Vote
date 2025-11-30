extension DurationExtension on Duration {
  /// mm:ss
  String toMmSs() {
    final totalSeconds = inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Human readable e.g. "2h 5m", "45s".
  String toReadable() {
    if (inSeconds < 60) return '${inSeconds}s';
    if (inMinutes < 60) return '${inMinutes}m ${inSeconds % 60}s';
    if (inHours < 24) return '${inHours}h ${(inMinutes % 60)}m';
    final days = inDays;
    final hours = inHours % 24;
    return '${days}d ${hours}h';
  }
}
