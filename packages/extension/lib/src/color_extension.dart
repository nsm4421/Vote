import 'package:flutter/painting.dart';

extension ColorExtension on Color {
  static Color fromHex(String hex) {
    final sanitized = hex.replaceFirst('#', '').toUpperCase();
    final buffer = StringBuffer();
    if (sanitized.length == 6) buffer.write('FF');
    buffer.write(sanitized.padLeft(8, 'F'));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// 0-100 percentage.
  Color withOpacityPercent(int percent) {
    final value = percent.clamp(0, 100) / 100;
    return withOpacity(value);
  }

  Color withOpacityClamped(double opacity) {
    final value = opacity.clamp(0.0, 1.0).toDouble();
    return withOpacity(value);
  }

  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) {
    final alpha = includeAlpha ? alphaComponent : '';
    final value = '${alpha}${redComponent}${greenComponent}${blueComponent}';
    return leadingHashSign ? '#$value' : value;
  }

  String get alphaComponent => alpha.toRadixString(16).padLeft(2, '0');
  String get redComponent => red.toRadixString(16).padLeft(2, '0');
  String get greenComponent => green.toRadixString(16).padLeft(2, '0');
  String get blueComponent => blue.toRadixString(16).padLeft(2, '0');
}
