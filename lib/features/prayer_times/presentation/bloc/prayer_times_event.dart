import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';

part 'prayer_times_event.freezed.dart';

@freezed
sealed class PrayerTimesEvent with _$PrayerTimesEvent {
  const factory PrayerTimesEvent.init({@Default(true) bool isArabic}) = PrayerTimesInit;
  const factory PrayerTimesEvent.checkInitialData({@Default(true) bool isArabic}) = PrayerTimesCheckInitialData;
  const factory PrayerTimesEvent.checkAllPermissions() = PrayerTimesCheckAllPermissions;
  const factory PrayerTimesEvent.fetchPrayerTimes({@Default(true) bool isArabic}) = PrayerTimesFetchPrayerTimes;
  const factory PrayerTimesEvent.loadNotificationSettings() = PrayerTimesLoadNotificationSettings;
  const factory PrayerTimesEvent.togglePrayerNotification({
    required PrayerType type,
    required bool enabled,
  }) = PrayerTimesTogglePrayerNotification;
  const factory PrayerTimesEvent.refreshPrayerTimes({@Default(true) bool isArabic}) = PrayerTimesRefreshPrayerTimes;
  const factory PrayerTimesEvent.countdownTicked() = PrayerTimesCountdownTicked;
  const factory PrayerTimesEvent.prayerTimesUpdated(LocalPrayerTimes times) = PrayerTimesPrayerTimesUpdated;
}
