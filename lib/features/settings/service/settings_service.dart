import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _prayerNotificationsKey = 'prayer_notifications';
  static const _quranNotificationsKey = 'quran_notifications';
  static const _autoLocationKey = 'auto_location_enabled';

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

  Future<void> setAutoLocationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoLocationKey, enabled);
  }

  Future<bool> getAutoLocationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoLocationKey) ?? true;
  }
}
