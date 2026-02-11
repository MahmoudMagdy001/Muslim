import '../../settings/service/settings_service.dart';
import '../model/prayer_times_model.dart';
import '../models/prayer_notification_settings_model.dart';
import '../models/prayer_type.dart';
import '../services/prayer_notification_canceler.dart';
import '../services/prayer_notification_scheduler.dart';
import 'prayer_notification_repository.dart';

/// Concrete implementation of [PrayerNotificationRepository].
///
/// Coordinates between [PrayerNotificationScheduler],
/// [PrayerNotificationCanceler], and [SettingsService].
class PrayerNotificationRepositoryImpl implements PrayerNotificationRepository {
  PrayerNotificationRepositoryImpl({
    required PrayerNotificationScheduler scheduler,
    required PrayerNotificationCanceler canceler,
    required SettingsService settingsService,
  }) : _scheduler = scheduler,
       _canceler = canceler,
       _settingsService = settingsService;

  final PrayerNotificationScheduler _scheduler;
  final PrayerNotificationCanceler _canceler;
  final SettingsService _settingsService;

  @override
  Future<void> scheduleNotifications(List<LocalPrayerTimes> days) async {
    final settings = await _settingsService.getPrayerNotificationSettings();
    await _scheduler.scheduleAll(days, settings);
  }

  @override
  Future<void> cancelAllNotifications() => _canceler.cancelAll();

  @override
  Future<PrayerNotificationSettings> getSettings() =>
      _settingsService.getPrayerNotificationSettings();

  @override
  Future<void> setPrayerEnabled(
    PrayerType type, {
    required bool enabled,
  }) async => _settingsService.setPrayerEnabled(type, enabled: enabled);
}
