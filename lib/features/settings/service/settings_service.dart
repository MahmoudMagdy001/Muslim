import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _notificationsKey = 'prayer_notifications';

  /// حفظ حالة الإشعارات
  Future<void> setPrayerNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  /// جلب حالة الإشعارات
  Future<bool> getPrayerNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true; // افتراضياً مفعلة
  }
}
