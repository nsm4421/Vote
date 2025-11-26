library app_theme;

import 'package:flutter/material.dart';

import 'src/app_theme_data.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => AppThemeData.light();

  static ThemeData get dark => AppThemeData.dark();
}