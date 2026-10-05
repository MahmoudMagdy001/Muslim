import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Available visual reading modes for the Quran reader
enum QuranReaderTheme {
  parchment,
  emeraldNight,
  pureWhite;

  String get displayNameAr => switch (this) {
        QuranReaderTheme.parchment => 'مصحف ورقي دافئ',
        QuranReaderTheme.emeraldNight => 'ليلي هادئ',
        QuranReaderTheme.pureWhite => 'ناصع البياض',
      };

  Color get backgroundColor => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFFFAF6EE),
        QuranReaderTheme.emeraldNight => const Color(0xFF0E1715),
        QuranReaderTheme.pureWhite => const Color(0xFFFFFFFF),
      };

  Color get textColor => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFF221F1A),
        QuranReaderTheme.emeraldNight => const Color(0xFFE8F1ED),
        QuranReaderTheme.pureWhite => const Color(0xFF142420),
      };

  Color get frameColor => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFFC7A867),
        QuranReaderTheme.emeraldNight => const Color(0xFFC59F48),
        QuranReaderTheme.pureWhite => const Color(0xFF143B33),
      };

  Color get activeAyahTextColor => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFF143B33),
        QuranReaderTheme.emeraldNight => const Color(0xFFFFE082),
        QuranReaderTheme.pureWhite => const Color(0xFF143B33),
      };

  Color get activeAyahHighlight => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFFD4AF37).withValues(alpha: 0.20),
        QuranReaderTheme.emeraldNight => const Color(0xFF1D5A4D).withValues(alpha: 0.35),
        QuranReaderTheme.pureWhite => const Color(0xFF143B33).withValues(alpha: 0.10),
      };

  Color get surahHeaderBackground => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFFEFE8DA),
        QuranReaderTheme.emeraldNight => const Color(0xFF162521),
        QuranReaderTheme.pureWhite => const Color(0xFFF1F6F4),
      };

  Color get surahHeaderBorder => switch (this) {
        QuranReaderTheme.parchment => const Color(0xFFD4AF37),
        QuranReaderTheme.emeraldNight => const Color(0xFFC59F48),
        QuranReaderTheme.pureWhite => const Color(0xFF143B33),
      };
}

/// Holds user preferences for Quran reading presentation
class QuranReaderSettings {
  const QuranReaderSettings({
    this.theme = QuranReaderTheme.parchment,
    this.fontSize = 22.0,
  });

  final QuranReaderTheme theme;
  final double fontSize;

  static const String _themeKey = 'quran_reader_theme_mode';
  static const String _fontSizeKey = 'quran_reader_font_size';

  QuranReaderSettings copyWith({
    QuranReaderTheme? theme,
    double? fontSize,
  }) =>
      QuranReaderSettings(
        theme: theme ?? this.theme,
        fontSize: fontSize ?? this.fontSize,
      );

  static Future<QuranReaderSettings> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey);
      final size = prefs.getDouble(_fontSizeKey);

      final selectedTheme = themeIndex != null &&
              themeIndex >= 0 &&
              themeIndex < QuranReaderTheme.values.length
          ? QuranReaderTheme.values[themeIndex]
          : QuranReaderTheme.parchment;

      return QuranReaderSettings(
        theme: selectedTheme,
        fontSize: size ?? 22.0,
      );
    } on Object {
      return const QuranReaderSettings();
    }
  }

  Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
      await prefs.setDouble(_fontSizeKey, fontSize);
    } on Object {
      // Ignored non-critical save failure
    }
  }
}
