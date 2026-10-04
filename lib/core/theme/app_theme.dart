library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import 'package:muslim/core/utils/extensions.dart';

part 'app_colors.dart';
part 'app_text_style.dart';

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
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: GoogleFonts.cairo().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.title.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      tabBarTheme: _lightTabBarTheme(textStyles),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: Color(0xFF1C4C42),
        secondary: AppColors.secondary,
        error: AppColors.errorLight,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: _buildLightTextTheme(textStyles),
      sliderTheme: _lightSliderTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme(textStyles),
      cardTheme: _cardTheme.copyWith(
        color: AppColors.lightCard,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.04),
      ),
      inputDecorationTheme: _lightInputDecorationTheme(textStyles),
      scrollbarTheme: _lightScrollbarTheme,
      snackBarTheme: _lightSnackBarTheme(textStyles),
      switchTheme: _lightSwitchTheme,
    );
  }

  ThemeData _buildDarkTheme() {
    final textStyles = AppTextStyles(fontSize);

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: GoogleFonts.cairo().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.title.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      tabBarTheme: _darkTabBarTheme(textStyles),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        primaryContainer: Color(0xFF14332C),
        secondary: AppColors.secondaryDark,
        surface: AppColors.darkSurface,
        error: AppColors.errorDark,
        onPrimary: AppColors.white,
        onSecondary: AppColors.black87,
      ),
      textTheme: _buildDarkTextTheme(textStyles),
      sliderTheme: _darkSliderTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme(textStyles),
      switchTheme: _darkSwitchTheme,
      cardTheme: _cardTheme.copyWith(
        color: AppColors.darkCard,
        elevation: 0,
      ),
      inputDecorationTheme: _darkInputDecorationTheme(textStyles),
      scrollbarTheme: _darkScrollbarTheme,
      snackBarTheme: _darkSnackBarTheme(textStyles),
    );
  }

  // Tab Bar Themes
  TabBarThemeData _lightTabBarTheme(AppTextStyles styles) => TabBarThemeData(
    indicator: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.secondary, width: 3)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.white70,
    labelStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: styles.titleSmall.copyWith(
      fontWeight: FontWeight.normal,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  );

  TabBarThemeData _darkTabBarTheme(AppTextStyles styles) => TabBarThemeData(
    indicator: const BoxDecoration(
      border: Border(bottom: BorderSide(color: AppColors.secondaryDark, width: 3)),
    ),
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.white70,
    labelStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: styles.titleSmall,
    indicatorSize: TabBarIndicatorSize.label,
  );

  // Text Themes
  TextTheme _buildLightTextTheme(AppTextStyles styles) => TextTheme(
        headlineLarge: styles.headlineLarge.copyWith(color: AppColors.textPrimary),
        headlineMedium: styles.headlineMedium.copyWith(color: AppColors.textPrimary),
        headlineSmall: styles.headlineSmall.copyWith(color: AppColors.textPrimary),
        titleLarge: styles.titleLarge.copyWith(color: AppColors.textPrimary),
        titleMedium: styles.titleMedium.copyWith(color: AppColors.textPrimary),
        titleSmall: styles.titleSmall.copyWith(color: AppColors.textPrimary),
        bodyLarge: styles.bodyLarge.copyWith(color: AppColors.textPrimary),
        bodyMedium: styles.bodyMedium.copyWith(color: AppColors.textSecondary),
        bodySmall: styles.bodySmall.copyWith(color: AppColors.textSecondary),
        labelLarge: styles.labelLarge.copyWith(color: AppColors.textPrimary),
        labelMedium: styles.labelMedium.copyWith(color: AppColors.textSecondary),
        displayMedium: styles.quranText.copyWith(color: AppColors.textPrimary),
      );

  TextTheme _buildDarkTextTheme(AppTextStyles styles) => TextTheme(
        headlineLarge: styles.headlineLarge.copyWith(color: AppColors.white),
        headlineMedium: styles.headlineMedium.copyWith(color: AppColors.white),
        headlineSmall: styles.headlineSmall.copyWith(color: AppColors.white),
        titleLarge: styles.titleLarge.copyWith(color: AppColors.white),
        titleMedium: styles.titleMedium.copyWith(color: AppColors.white),
        titleSmall: styles.titleSmall.copyWith(color: AppColors.white),
        bodyLarge: styles.bodyLarge.copyWith(color: AppColors.white),
        bodyMedium: styles.bodyMedium.copyWith(color: AppColors.white70),
        bodySmall: styles.bodySmall.copyWith(color: AppColors.white70),
        labelLarge: styles.labelLarge.copyWith(color: AppColors.white),
        labelMedium: styles.labelMedium.copyWith(color: AppColors.white70),
        displayMedium: styles.quranText.copyWith(color: AppColors.white),
      );

  // Component Themes
  static const SliderThemeData _lightSliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.lightInactiveTrack,
    thumbColor: AppColors.primary,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  static const SliderThemeData _darkSliderTheme = SliderThemeData(
    activeTrackColor: AppColors.secondaryDark,
    inactiveTrackColor: AppColors.darkInactiveTrack,
    thumbColor: AppColors.secondaryDark,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
  );

  ElevatedButtonThemeData _lightElevatedButtonTheme(AppTextStyles styles) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      );

  SnackBarThemeData _lightSnackBarTheme(AppTextStyles styles) =>
      SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: styles.bodyMedium.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        showCloseIcon: true,
      );

  SnackBarThemeData _darkSnackBarTheme(AppTextStyles styles) =>
      SnackBarThemeData(
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: styles.bodyMedium.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        showCloseIcon: true,
      );

  ElevatedButtonThemeData _darkElevatedButtonTheme(AppTextStyles styles) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
          textStyle: styles.titleSmall.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      );

  static final CardThemeData _cardTheme = CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFFE2ECE8), width: 0.8),
    ),
  );

  InputDecorationTheme _lightInputDecorationTheme(AppTextStyles styles) =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE2ECE8), width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 1.2),
        ),
        labelStyle: styles.bodyMedium.copyWith(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  InputDecorationTheme _darkInputDecorationTheme(AppTextStyles styles) =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF253732), width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.secondaryDark, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 1.2),
        ),
        labelStyle: styles.bodyMedium.copyWith(color: AppColors.white70),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );

  static final SwitchThemeData _lightSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.white,
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary.withAlpha((0.25 * 255).toInt())
          : AppColors.lightInactiveTrack,
    ),
  );

  static final SwitchThemeData _darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.secondaryDark
          : Colors.grey,
    ),
    trackColor: WidgetStateProperty.resolveWith<Color>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.secondaryDark.withAlpha((0.25 * 255).toInt())
          : AppColors.darkInactiveTrack,
    ),
  );

  static final ScrollbarThemeData _lightScrollbarTheme = ScrollbarThemeData(
    thickness: WidgetStateProperty.all(6.0),
    radius: const Radius.circular(16),
    thumbColor: WidgetStateProperty.all(
      AppColors.primary.withAlpha((0.35 * 255).toInt()),
    ),
    thumbVisibility: WidgetStateProperty.all(false),
    trackVisibility: WidgetStateProperty.all(false),
    crossAxisMargin: 2.0,
    mainAxisMargin: 4.0,
    minThumbLength: 50.0,
    interactive: true,
  );

  static final ScrollbarThemeData _darkScrollbarTheme = ScrollbarThemeData(
    thickness: WidgetStateProperty.all(6.0),
    radius: const Radius.circular(16),
    thumbColor: WidgetStateProperty.all(
      AppColors.secondaryDark.withAlpha((0.35 * 255).toInt()),
    ),
    thumbVisibility: WidgetStateProperty.all(false),
    trackVisibility: WidgetStateProperty.all(false),
    crossAxisMargin: 2.0,
    mainAxisMargin: 4.0,
    minThumbLength: 50.0,
    interactive: true,
  );
}
