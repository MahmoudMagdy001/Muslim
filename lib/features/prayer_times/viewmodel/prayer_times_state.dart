import 'package:equatable/equatable.dart';

import '../model/prayer_times_model.dart';
import '../models/prayer_notification_settings_model.dart';
import '../models/prayer_type.dart';

/// Status of prayer times loading.
enum RequestStatus { initial, loading, success, failure }

/// Immutable state for the PrayerTimesCubit.
class PrayerTimesState extends Equatable {
  const PrayerTimesState({
    this.status = RequestStatus.initial,
    this.localPrayerTimes,
    this.nextPrayer,
    this.timeLeft,
    this.previousPrayerDateTime,
    this.message,
    this.lastUpdated,
    this.city,
    this.notificationSettings = const PrayerNotificationSettings(),
  });

  final RequestStatus status;
  final LocalPrayerTimes? localPrayerTimes;
  final PrayerType? nextPrayer;
  final Duration? timeLeft;
  final DateTime? previousPrayerDateTime;
  final String? message;
  final DateTime? lastUpdated;
  final String? city;
  final PrayerNotificationSettings notificationSettings;

  @override
  List<Object?> get props => [
    status,
    localPrayerTimes,
    nextPrayer,
    timeLeft,
    previousPrayerDateTime,
    message,
    lastUpdated,
    city,
    notificationSettings,
  ];

  PrayerTimesState copyWith({
    RequestStatus? status,
    LocalPrayerTimes? localPrayerTimes,
    PrayerType? nextPrayer,
    Duration? timeLeft,
    DateTime? previousPrayerDateTime,
    String? message,
    DateTime? lastUpdated,
    String? city,
    PrayerNotificationSettings? notificationSettings,
  }) => PrayerTimesState(
    status: status ?? this.status,
    localPrayerTimes: localPrayerTimes ?? this.localPrayerTimes,
    nextPrayer: nextPrayer ?? this.nextPrayer,
    timeLeft: timeLeft ?? this.timeLeft,
    previousPrayerDateTime:
        previousPrayerDateTime ?? this.previousPrayerDateTime,
    message: message ?? this.message,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    city: city ?? this.city,
    notificationSettings: notificationSettings ?? this.notificationSettings,
  );
}
