import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import 'app_colors.dart' show AppColors;
import 'app_text_style.dart' show AppTextStyles;

/// App theme configurations
class AppThemeFactory {
  AppThemeFactory(this.fontSize);
  final double fontSize;

  ThemeData get lightTheme => _buildLightTheme();
  ThemeData get darkTheme => _buildDarkTheme();

  ThemeData _buildLightTheme() {
    final textStyles = AppTextStyles(fontSize);

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: GoogleFonts.amiri().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.title.copyWith(color: AppColors.white),
      ),
      tabBarTheme: _lightTabBarTheme(textStyles), // إضافة tab bar theme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.white,
        error: AppColors.errorLight,
        onSecondary: AppColors.black87,
        onSurface: AppColors.black87,
      ),
      textTheme: _buildLightTextTheme(textStyles),
      sliderTheme: _lightSliderTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme(textStyles),
      cardTheme: _cardTheme.copyWith(color: AppColors.lightCard),
      inputDecorationTheme: _lightInputDecorationTheme(textStyles),
      scrollbarTheme: _lightScrollbarTheme, // إضافة scrollbar theme
      snackBarTheme: _lightSnackBarTheme(textStyles),
    );
  }

  ThemeData _buildDarkTheme() {
    final textStyles = AppTextStyles(fontSize);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: GoogleFonts.amiri().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.title.copyWith(color: AppColors.white),
      ),
      tabBarTheme: _darkTabBarTheme(textStyles), // إضافة tab bar theme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.white,
        surface: AppColors.darkSurface,
        error: AppColors.errorDark,
        onPrimary: AppColors.white,
        onSecondary: AppColors.black87,
      ),
      textTheme: _buildDarkTextTheme(textStyles),
      sliderTheme: _darkSliderTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme(textStyles),
      switchTheme: _switchTheme,
      cardTheme: _cardTheme.copyWith(color: AppColors.darkCard),
      inputDecorationTheme: _darkInputDecorationTheme(textStyles),
      scrollbarTheme: _darkScrollbarTheme, // إضافة scrollbar theme
      snackBarTheme: _darkSnackBarTheme(textStyles),
    );
  }

  // Tab Bar Themes
  TabBarThemeData _lightTabBarTheme(AppTextStyles styles) => TabBarThemeData(
    indicator: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.white, width: 3)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.black54,
    labelStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: styles.titleSmall.copyWith(
      fontWeight: FontWeight.normal,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  );

  TabBarThemeData _darkTabBarTheme(AppTextStyles styles) => TabBarThemeData(
    indicator: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.primary, width: 3)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: Colors.white70,
    labelStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: styles.titleSmall,
    indicatorSize: TabBarIndicatorSize.label,
  );

  // Text Themes
  TextTheme _buildLightTextTheme(AppTextStyles styles) =>
      GoogleFonts.amiriTextTheme().copyWith(
        headlineLarge: styles.headlineLarge.copyWith(color: AppColors.black87),
        headlineMedium: styles.headlineMedium.copyWith(
          color: AppColors.black87,
        ),
        headlineSmall: styles.headlineSmall.copyWith(color: AppColors.black87),
        titleLarge: styles.titleLarge.copyWith(color: AppColors.black87),
        titleMedium: styles.titleMedium.copyWith(color: AppColors.black87),
        titleSmall: styles.titleSmall.copyWith(color: AppColors.black87),
        bodyLarge: styles.bodyLarge.copyWith(color: AppColors.black87),
        bodyMedium: styles.bodyMedium.copyWith(color: AppColors.black54),
        bodySmall: styles.bodySmall.copyWith(color: AppColors.black54),
        labelLarge: styles.labelLarge.copyWith(color: AppColors.black87),
        labelMedium: styles.labelMedium.copyWith(color: AppColors.black54),
      );

  TextTheme _buildDarkTextTheme(AppTextStyles styles) =>
      GoogleFonts.amiriTextTheme().copyWith(
        headlineLarge: styles.headlineLarge.copyWith(color: AppColors.white),
        headlineMedium: styles.headlineMedium.copyWith(color: AppColors.white),
        headlineSmall: styles.headlineSmall.copyWith(color: AppColors.white),
        titleLarge: styles.titleLarge.copyWith(color: AppColors.white),
        titleMedium: styles.titleMedium.copyWith(color: AppColors.white),
        titleSmall: styles.titleSmall.copyWith(color: AppColors.white),
        bodyLarge: styles.bodyLarge.copyWith(color: AppColors.white),
        bodyMedium: styles.bodyMedium.copyWith(color: Colors.white70),
        bodySmall: styles.bodySmall.copyWith(color: Colors.white70),
        labelLarge: styles.labelLarge.copyWith(color: AppColors.white),
        labelMedium: styles.labelMedium.copyWith(color: Colors.white70),
      );

  // Component Themes
  static const SliderThemeData _lightSliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.lightInactiveTrack,
    thumbColor: AppColors.primary,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  static const SliderThemeData _darkSliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.darkInactiveTrack,
    thumbColor: AppColors.primary,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  ElevatedButtonThemeData _lightElevatedButtonTheme(AppTextStyles styles) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: styles.titleSmall,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      );

  SnackBarThemeData _lightSnackBarTheme(AppTextStyles styles) =>
      const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      );
  SnackBarThemeData _darkSnackBarTheme(AppTextStyles styles) =>
      const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      );

  ElevatedButtonThemeData _darkElevatedButtonTheme(AppTextStyles styles) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withAlpha((0.2 * 255).toInt()),
          foregroundColor: AppColors.white,
          textStyle: styles.titleSmall,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      );

  static final CardThemeData _cardTheme = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  InputDecorationTheme _lightInputDecorationTheme(AppTextStyles styles) =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: styles.bodyLarge.copyWith(color: AppColors.black54),
      );

  InputDecorationTheme _darkInputDecorationTheme(AppTextStyles styles) =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: styles.bodyLarge.copyWith(color: Colors.white70),
      );

  static final SwitchThemeData _switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : Colors.grey.shade300,
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? AppColors.primary.withAlpha((0.3 * 255).toInt())
          : Colors.grey.shade600,
    ),
  );

  static final ScrollbarThemeData _lightScrollbarTheme = ScrollbarThemeData(
    thickness: WidgetStateProperty.all(8.0),
    radius: const Radius.circular(16),
    thumbColor: WidgetStateProperty.all(
      AppColors.primary.withAlpha((0.5 * 255).toInt()),
    ),
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(true),

    crossAxisMargin: 2.0,
    mainAxisMargin: 4.0,
    minThumbLength: 50.0,
    interactive: true,
  );

  static final ScrollbarThemeData _darkScrollbarTheme = ScrollbarThemeData(
    thickness: WidgetStateProperty.all(8.0),
    radius: const Radius.circular(16),
    thumbColor: WidgetStateProperty.all(
      AppColors.primary.withAlpha((0.7 * 255).toInt()),
    ),
    thumbVisibility: WidgetStateProperty.all(true),
    trackVisibility: WidgetStateProperty.all(true),

    crossAxisMargin: 2.0,
    mainAxisMargin: 4.0,
    minThumbLength: 50.0,
    interactive: true,
  );
}
