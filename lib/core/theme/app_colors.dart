import 'package:flutter/material.dart';

import '../utils/extensions.dart';

/// App color palette
class AppColors {
  const AppColors._();

  // ================== Base Colors ==================
  static const Color primary = Color(0xff4C406F);
  static const Color secondary = Color(0xffE0FF50);

  static const Color primaryDark = Color(0xff362C54);
  static const Color secondaryDark = Color(0xffB6CC3F);

  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color white70 = Colors.white70;

  static const Color errorLight = Color(0xFFE74C3C);
  static const Color errorDark = Color(0xFFFF9A8B);

  static const Color darkBackground = Color(0xFF201A2B); // Deep purple-black
  static const Color darkSurface = Color(0xFF2A2342); // Slightly lighter
  static const Color darkCard = Color(0xFF2A2342);
  static const Color darkInputFill = Color(0xFF382E59);
  static const Color darkInactiveTrack = Color(0xFF4A5568);

  static const Color lightInputFill = Color(0xFFF5F5F5);
  static const Color lightInactiveTrack = Color(0xFFE2E8F0);
  static const Color lightCard = Color(0xFFFFFFFF);

  // ================== Private Gradients ==================
  static const List<Color> _cardGradientLight = [
    Color(0xff7C6FB3),
    Color(0xff4C406F),
  ];

  static const List<Color> _cardGradientDark = [
    Color(0xff4C406F),
    Color(0xff2A2342),
  ];

  // ================== Public Smart Gradient ==================
  static List<Color> cardGradient(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return isDark ? _cardGradientDark : _cardGradientLight;
  }
}
