part of 'app_theme.dart';

/// App color palette
class AppColors {
  const AppColors._();

  // ================== Base Colors ==================
  static const Color primary = Color(0xFF143B33); // Noble Deep Emerald
  static const Color secondary = Color(0xFFC59F48); // Warm Sacred Antique Gold

  static const Color primaryDark = Color(0xFF1B4A40); // Midnight Emerald
  static const Color secondaryDark = Color(0xFFDBB358); // Luminous Warm Gold

  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color white70 = Colors.white70;

  static const Color errorLight = Color(0xFFC62828);
  static const Color errorDark = Color(0xFFEF5350);

  static const Color darkBackground = Color(0xFF0F1715); // Deep emerald slate
  static const Color darkSurface = Color(0xFF16221F); // Elevated emerald surface
  static const Color darkCard = Color(0xFF16221F);
  static const Color darkInputFill = Color(0xFF1B2A26);
  static const Color darkInactiveTrack = Color(0xFF2E423D);

  static const Color lightBackground = Color(0xFFFAF8F5); // Warm Soft Parchment
  static const Color lightInputFill = Color(0xFFF1F5F3);
  static const Color lightInactiveTrack = Color(0xFFD6E3DF);
  static const Color lightCard = Color(0xFFFFFFFF);

  // ================== Text Colors ==================
  static const Color textPrimary = Color(0xFF162521);
  static const Color textSecondary = Color(0xFF5A726C);

  // ================== Private Gradients ==================
  static const List<Color> _cardGradientLight = [
    Color(0xFF245248),
    Color(0xFF143B33),
  ];

  static const List<Color> _cardGradientDark = [
    Color(0xFF1C473E),
    Color(0xFF0E2721),
  ];

  // ================== Public Smart Gradient ==================
  static List<Color> cardGradient(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return isDark ? _cardGradientDark : _cardGradientLight;
  }
}
