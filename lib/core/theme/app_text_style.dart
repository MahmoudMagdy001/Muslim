import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// App text styles with responsive sizing
class AppTextStyles {
  AppTextStyles(this.baseFontSize);
  final double baseFontSize;

  TextStyle get title => GoogleFonts.cairo(
    fontSize: (baseFontSize + 4).sp,
    fontWeight: FontWeight.w600,
  );

  TextStyle get headlineLarge => GoogleFonts.cairo(
    fontSize: (baseFontSize + 16).sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle get headlineMedium => GoogleFonts.cairo(
    fontSize: (baseFontSize + 8).sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle get headlineSmall => GoogleFonts.cairo(
    fontSize: (baseFontSize + 4).sp,
    fontWeight: FontWeight.bold,
  );

  TextStyle get titleLarge => GoogleFonts.cairo(
    fontSize: (baseFontSize + 6).sp,
    fontWeight: FontWeight.w600,
  );

  TextStyle get titleMedium => GoogleFonts.cairo(
    fontSize: (baseFontSize + 2).sp,
    fontWeight: FontWeight.w600,
  );

  TextStyle get titleSmall =>
      GoogleFonts.cairo(fontSize: baseFontSize.sp, fontWeight: FontWeight.w600);

  TextStyle get bodyLarge => GoogleFonts.cairo(fontSize: baseFontSize.sp);

  TextStyle get bodyMedium =>
      GoogleFonts.cairo(fontSize: (baseFontSize - 2).sp);

  TextStyle get bodySmall => GoogleFonts.cairo(fontSize: (baseFontSize - 6).sp);

  TextStyle get labelLarge => GoogleFonts.cairo(fontSize: baseFontSize.sp);

  TextStyle get labelMedium =>
      GoogleFonts.cairo(fontSize: (baseFontSize - 2).sp);
}
