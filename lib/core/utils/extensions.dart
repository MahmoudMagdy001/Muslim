import 'package:flutter/material.dart';
import 'package:muslim/core/theme/design_system.dart';
import 'package:muslim/l10n/app_localizations.dart';

/// Context Extensions for Design System and Presentation
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

  /// Design System Semantic Colors
  AppSemanticColors get colors =>
      theme.brightness == Brightness.dark
          ? AppSemanticColors.dark
          : AppSemanticColors.light;

  /// Design System Typography
  AppTypography get typography => AppTypography(textTheme, colors);

  /// Design System Radiuses
  AppRadius get radius => const AppRadius();

  /// Design System Durations
  AppDurations get durations => const AppDurations();

  /// Design System Spacing Tokens
  AppSpacing get spacing => const AppSpacing();

  /// Design System Sizes Tokens
  AppSizes get sizes => const AppSizes();

  /// Returns theme-aware card gradient colors
  List<Color> get cardGradient => colors.cardGradient;
}
