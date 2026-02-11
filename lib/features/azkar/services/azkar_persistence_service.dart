import 'package:shared_preferences/shared_preferences.dart';

class AzkarPersistenceService {
  static const String _lastUpdateDateKey = 'azkar_last_update_date';
  static const String _azkarCountPrefix = 'azkar_count_';

  Future<void> saveCount(String sourceUrl, int index, int count) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _generateKey(sourceUrl, index);
    await prefs.setInt(key, count);
  }

  Future<int?> getCount(String sourceUrl, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _generateKey(sourceUrl, index);
    return prefs.getInt(key);
  }

  Future<void> clearIfNewDay() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final lastUpdate = prefs.getString(_lastUpdateDateKey);

    if (lastUpdate != today) {
      // Clear all Azkar counts
      final keys = prefs.getKeys();
      final azkarKeys = keys
          .where((k) => k.startsWith(_azkarCountPrefix))
          .toList();

      for (final key in azkarKeys) {
        await prefs.remove(key);
      }

      await prefs.setString(_lastUpdateDateKey, today);
    }
  }

  String _generateKey(String sourceUrl, int index) {
    // Sanitize URL to use as part of the key
    final sanitizedUrl = sourceUrl.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return '$_azkarCountPrefix${sanitizedUrl}_$index';
  }

  String _getTodayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
