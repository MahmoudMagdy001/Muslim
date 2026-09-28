part of 'app_theme.dart';

/// App color palette
class AppColors {
  const AppColors._();

  // ================== Base Colors ==================
  static const Color primary = Color(0xff1A3B34); // Deep Emerald
  static const Color secondary = Color(0xffD4AF37); // Warm Sacred Gold

  static const Color primaryDark = Color(0xff0E231F); // Midnight Emerald
  static const Color secondaryDark = Color(0xffE5C467); // Luminous Warm Gold

  static const Color white = Colors.white;
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color white70 = Colors.white70;

  static const Color errorLight = Color(0xFFE74C3C);
  static const Color errorDark = Color(0xFFFF9A8B);

  static const Color darkBackground = Color(0xFF101715); // Deep emerald slate
  static const Color darkSurface = Color(0xFF182421); // Elevated emerald surface
  static const Color darkCard = Color(0xFF182421);
  static const Color darkInputFill = Color(0xFF22302D);
  static const Color darkInactiveTrack = Color(0xFF3B4E49);

  static const Color lightInputFill = Color(0xFFF4F7F5);
  static const Color lightInactiveTrack = Color(0xFFDCE5E2);
  static const Color lightCard = Color(0xFFFFFFFF);

  // ================== Text Colors ==================
  static const Color textPrimary = Color(0xFF192522);
  static const Color textSecondary = Color(0xFF5D716C);

  // ================== Private Gradients ==================
  static const List<Color> _cardGradientLight = [
    Color(0xff2A574E),
    Color(0xff1A3B34),
  ];

  static const List<Color> _cardGradientDark = [
    Color(0xff1A3B34),
    Color(0xff0E231F),
  ];

  // ================== Public Smart Gradient ==================
  static List<Color> cardGradient(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    return isDark ? _cardGradientDark : _cardGradientLight;
  }
}
