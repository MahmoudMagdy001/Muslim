import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastReadService {
  static const String lastSurahKey = 'last_surah_number';
  static const String lastAyahKey = 'last_ayah_number';
  static const String lastDateKey = 'last_opened_date';

  Future<void> saveLastRead({required int surah, required int ayah}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(lastAyahKey, ayah);
      await prefs.setInt(lastSurahKey, surah);
      await prefs.setString(
        lastDateKey,
        DateTime.now().toString().split(' ')[0],
      );
    } catch (e) {
      debugPrint('Error saving last read: $e');
    }
  }

  Future<Map<String, dynamic>> loadLastRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSurah = prefs.getInt(lastSurahKey);
      final lastAyah = prefs.getInt(lastAyahKey);
      final lastDate = prefs.getString(lastDateKey);

      return {'surah': lastSurah, 'ayah': lastAyah, 'lastOpened': lastDate};
    } catch (e) {
      debugPrint('Error loading last read: $e');
      return {'surah': null, 'ayah': null, 'lastOpened': null};
    }
  }

  Future<void> clearLastRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(lastSurahKey);
      await prefs.remove(lastAyahKey);
      await prefs.remove(lastDateKey);
    } catch (e) {
      debugPrint('Error clearing last read: $e');
    }
  }
}
