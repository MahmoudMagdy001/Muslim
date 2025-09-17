import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App text styles with responsive sizing
class AppTextStyles {
  AppTextStyles(this.baseFontSize);
  final double baseFontSize;

  TextStyle get title => GoogleFonts.amiri(
    fontSize: baseFontSize + 4,
    fontWeight: FontWeight.w600,
  );

  TextStyle get headlineLarge => GoogleFonts.amiri(
    fontSize: baseFontSize + 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle get headlineMedium => GoogleFonts.amiri(
    fontSize: baseFontSize + 8,
    fontWeight: FontWeight.bold,
  );

  TextStyle get headlineSmall => GoogleFonts.amiri(
    fontSize: baseFontSize + 4,
    fontWeight: FontWeight.bold,
  );

  TextStyle get titleLarge => GoogleFonts.amiri(
    fontSize: baseFontSize + 6,
    fontWeight: FontWeight.w600,
  );

  TextStyle get titleMedium => GoogleFonts.amiri(
    fontSize: baseFontSize + 2,
    fontWeight: FontWeight.w600,
  );

  TextStyle get titleSmall =>
      GoogleFonts.amiri(fontSize: baseFontSize, fontWeight: FontWeight.w600);

  TextStyle get bodyLarge => GoogleFonts.amiri(fontSize: baseFontSize);

  TextStyle get bodyMedium => GoogleFonts.amiri(fontSize: baseFontSize - 2);

  TextStyle get bodySmall => GoogleFonts.amiri(fontSize: baseFontSize - 4);

  TextStyle get labelLarge => GoogleFonts.amiri(fontSize: baseFontSize);

  TextStyle get labelMedium => GoogleFonts.amiri(fontSize: baseFontSize - 2);
}
