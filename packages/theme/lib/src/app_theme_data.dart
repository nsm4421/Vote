import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_text_theme.dart';

class AppThemeData {
  const AppThemeData._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: AppColorSchemes.light,
      scaffoldBackgroundColor: AppColorSchemes.light.background,
      textTheme: AppTextThemes.light,
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: AppColorSchemes.light.surface,
        foregroundColor: AppColorSchemes.light.onSurface,
      ),
      cardTheme: base.cardTheme.copyWith(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: AppColorSchemes.dark,
      scaffoldBackgroundColor: AppColorSchemes.dark.background,
      textTheme: AppTextThemes.dark,
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: AppColorSchemes.dark.surface,
        foregroundColor: AppColorSchemes.dark.onSurface,
      ),
      cardTheme: base.cardTheme.copyWith(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
