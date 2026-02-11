import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Context Extensions
extension ContextExtension on BuildContext {
  /// Returns MediaQuery size
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns screen width
  double get screenWidth => screenSize.width;

  /// Returns screen height
  double get screenHeight => screenSize.height;

  /// Returns current theme
  ThemeData get theme => Theme.of(this);

  /// Returns text theme
  TextTheme get textTheme => theme.textTheme;

  /// Returns color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns localizations
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Returns if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Hides keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
