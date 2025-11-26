import 'package:flutter/material.dart';

import 'palette.dart';

class AppTextThemes {
  const AppTextThemes._();

  static TextTheme light = _base.apply(
    fontFamily: 'Inter',
    displayColor: AppPalette.navy900,
    bodyColor: AppPalette.navy900,
  );

  static TextTheme dark = _base.apply(
    fontFamily: 'Inter',
    displayColor: Colors.white,
    bodyColor: Colors.white,
  );

  static const TextTheme _base = TextTheme(
    displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  );
}
