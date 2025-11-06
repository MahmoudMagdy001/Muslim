import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _prayerNotificationsKey = 'prayer_notifications';
  static const _quranNotificationsKey = 'quran_notifications';

  Future<void> setPrayerNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prayerNotificationsKey, enabled);
  }

  Future<void> setQuranNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotificationsKey, enabled);
  }

  Future<bool> getPrayerNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prayerNotificationsKey) ?? true;
  }

  Future<bool> getQuranNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_quranNotificationsKey) ?? true;
  }
}
