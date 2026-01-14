part of 'app_theme.dart';

/// App color palette
class AppColors {
  const AppColors._();

  // ================== Base Colors ==================
  static const Color primary = Color(0xff589C94);
  static const Color secondary = Color(0xffC9E5E2);

  static const Color primaryDark = Color(0xff3D6E68);
  static const Color secondaryDark = Color(0xff4A6E6A);

  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color white70 = Colors.white70;

  static const Color errorLight = Color(0xFFE74C3C);
  static const Color errorDark = Color(0xFFFF9A8B);

  static const Color darkBackground = Color(0xFF1A2624); // Dark teal-black
  static const Color darkSurface = Color(0xFF23312F); // Slightly lighter
  static const Color darkCard = Color(0xFF23312F);
  static const Color darkInputFill = Color(0xFF2F413F);
  static const Color darkInactiveTrack = Color(0xFF4A5553);

  static const Color lightInputFill = Color(0xFFF0F5F4);
  static const Color lightInactiveTrack = Color(0xFFE2E8E7);
  static const Color lightCard = Color(0xFFFFFFFF);

  // ================== Text Colors ==================
  static const Color textPrimary = Color(0xFF2D3635);
  static const Color textSecondary = Color(0xFF637271);

  // ================== Private Gradients ==================
  static const List<Color> _cardGradientLight = [
    Color(0xFF7FB6AF),
    Color(0xFF589C94),
  ];

  static const List<Color> _cardGradientDark = [
    Color(0xFF589C94),
    Color(0xFF23312F),
  ];

  // ================== Public Smart Gradient ==================
  static List<Color> cardGradient(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return isDark ? _cardGradientDark : _cardGradientLight;
  }
}
