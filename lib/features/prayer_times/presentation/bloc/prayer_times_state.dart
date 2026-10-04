import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_notification_settings.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';

part 'prayer_times_state.freezed.dart';

enum RequestStatus { initial, loading, success, failure }

@freezed
abstract class PrayerTimesState with _$PrayerTimesState {
  const factory PrayerTimesState({
    @Default(RequestStatus.initial) RequestStatus status,
    LocalPrayerTimes? localPrayerTimes,
    PrayerType? nextPrayer,
    Duration? timeLeft,
    DateTime? previousPrayerDateTime,
    DateTime? lastUpdated,
    String? city,
    String? message,
    @Default(PrayerNotificationSettings())
    PrayerNotificationSettings notificationSettings,
  }) = _PrayerTimesState;
}
