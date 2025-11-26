import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  /// size, height, width
  MediaQueryData get _mediaQueryData => MediaQuery.of(this);

  Size get screenSize => _mediaQueryData.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  double get keyboardHeight => _mediaQueryData.viewInsets.bottom;

  bool get isKeyboardVisible => keyboardHeight > 0;

  double get safeTop => _mediaQueryData.padding.top;

  double get safeBottom => _mediaQueryData.padding.bottom;

  double get safeHeight =>
      screenHeight - _mediaQueryData.padding.vertical - keyboardHeight;

  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// localization
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Theme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
