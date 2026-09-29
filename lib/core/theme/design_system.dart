import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Semantic colors for the Muslim App Design System
class AppSemanticColors {
  const AppSemanticColors({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.error,
    required this.success,
    required this.card,
    required this.accentGold,
    required this.cardGradient,
    required this.isDark,
  });

  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color error;
  final Color success;
  final Color card;
  final Color accentGold;
  final List<Color> cardGradient;
  final bool isDark;

  static const AppSemanticColors light = AppSemanticColors(
    primary: Color(0xFF143B33), // Noble Deep Emerald
    primaryContainer: Color(0xFF1C4C42), // Rich Forest Emerald
    secondary: Color(0xFFC59F48), // Warm Sacred Antique Gold
    background: Color(0xFFFAF8F5), // Soft Warm Parchment
    surface: Color(0xFFFFFFFF), // Pristine White Surface
    surfaceVariant: Color(0xFFF1F5F3), // Muted Sage-Cream Surface
    textPrimary: Color(0xFF162521), // Charcoal Forest Dark
    textSecondary: Color(0xFF5A726C), // Balanced Olive-Sage
    border: Color(0xFFE2ECE8), // Subtle Pale Border
    error: Color(0xFFC62828), // Deep Crimson
    success: Color(0xFF2E7D32), // Forest Green
    card: Color(0xFFFFFFFF),
    accentGold: Color(0xFFC59F48),
    cardGradient: [
      Color(0xFF245248),
      Color(0xFF143B33),
    ],
    isDark: false,
  );

  static const AppSemanticColors dark = AppSemanticColors(
    primary: Color(0xFF1B4A40), // Elevated Deep Emerald
    primaryContainer: Color(0xFF14332C), // Night Canopy Emerald
    secondary: Color(0xFFDBB358), // Radiant Antique Gold
    background: Color(0xFF0F1715), // Midnight Emerald Slate
    surface: Color(0xFF16221F), // Deep Elevated Night Surface
    surfaceVariant: Color(0xFF1F2F2B), // Night Sage Tint
    textPrimary: Color(0xFFF4F7F6), // Calm Warm White
    textSecondary: Color(0xFF96ABA5), // Soft Night Sage
    border: Color(0xFF253732), // Night Divider Line
    error: Color(0xFFEF5350), // Soft Crimson
    success: Color(0xFF66BB6A), // Fresh Meadow Leaf
    card: Color(0xFF16221F),
    accentGold: Color(0xFFDBB358),
    cardGradient: [
      Color(0xFF1C473E),
      Color(0xFF0E2721),
    ],
    isDark: true,
  );
}

/// Dynamic Typography hierarchy for Muslim App Design System
class AppTypography {
  AppTypography(this.textTheme, this.colors);

  final TextTheme textTheme;
  final AppSemanticColors colors;

  TextStyle get h1 => GoogleFonts.cairo(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
        height: 1.3,
      );

  TextStyle get h2 => GoogleFonts.cairo(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
        height: 1.35,
      );

  TextStyle get h3 => GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
        height: 1.4,
      );

  TextStyle get titleLarge => GoogleFonts.cairo(
        fontSize: 17.sp,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        height: 1.4,
      );

  TextStyle get titleMedium => GoogleFonts.cairo(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.4,
      );

  TextStyle get titleSmall => GoogleFonts.cairo(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.4,
      );

  TextStyle get body => GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: colors.textPrimary,
        height: 1.5,
      );

  TextStyle get bodySmall => GoogleFonts.cairo(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: colors.textSecondary,
        height: 1.45,
      );

  TextStyle get caption => GoogleFonts.cairo(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
        height: 1.35,
      );

  TextStyle get labelLarge => GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
        height: 1.3,
      );

  TextStyle get quran => GoogleFonts.amiri(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
        height: 2.2,
      );

  TextStyle get counter => GoogleFonts.cairo(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: colors.textPrimary,
        height: 1.1,
      );
}

/// Standardized border radiuses
class AppRadius {
  const AppRadius();

  double get xs => 4.0.r;
  double get sm => 8.0.r;
  double get md => 12.0.r;
  double get lg => 16.0.r;
  double get xl => 24.0.r;
  double get full => 999.0.r;

  BorderRadius get xsBorder => BorderRadius.circular(4.0.r);
  BorderRadius get smBorder => BorderRadius.circular(8.0.r);
  BorderRadius get mdBorder => BorderRadius.circular(12.0.r);
  BorderRadius get lgBorder => BorderRadius.circular(16.0.r);
  BorderRadius get xlBorder => BorderRadius.circular(24.0.r);
  BorderRadius get fullBorder => BorderRadius.circular(999.0.r);
}

/// Standardized animation durations
class AppDurations {
  const AppDurations();

  Duration get fast => const Duration(milliseconds: 150);
  Duration get normal => const Duration(milliseconds: 300);
  Duration get slow => const Duration(milliseconds: 500);
}

/// Standardized spacing tokens
class AppSpacing {
  const AppSpacing();

  double get xxs => 2.0.w;
  double get xs => 4.0.w;
  double get sm => 8.0.w;
  double get md => 12.0.w;
  double get lg => 16.0.w;
  double get xl => 24.0.w;
  double get xxl => 32.0.w;
}

/// Standardized size tokens
class AppSizes {
  const AppSizes();

  double get buttonHeight => 48.0.h;
  double get inputHeight => 52.0.h;
  double get minTouchTarget => 48.0.h;
  double get iconSmall => 16.0.r;
  double get iconMedium => 24.0.r;
  double get iconLarge => 32.0.r;
}
