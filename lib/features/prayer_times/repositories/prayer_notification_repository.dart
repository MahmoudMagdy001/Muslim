import '../model/prayer_times_model.dart';
import '../models/prayer_notification_settings_model.dart';
import '../models/prayer_type.dart';

/// Abstract repository for prayer notification operations.
abstract class PrayerNotificationRepository {
  /// Schedules notifications for the given [days], respecting per-prayer settings.
  Future<void> scheduleNotifications(List<LocalPrayerTimes> days);

  /// Cancels all scheduled prayer notifications.
  Future<void> cancelAllNotifications();

  /// Returns the current per-prayer notification settings.
  Future<PrayerNotificationSettings> getSettings();

  /// Sets the enabled state for a specific [type] prayer.
  Future<void> setPrayerEnabled(PrayerType type, {required bool enabled});
}
