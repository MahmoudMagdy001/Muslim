import 'package:equatable/equatable.dart';
import '../model/prayer_times_model.dart';

enum PrayerTimesStatus {
  initial,
  checkingPermissions,
  loading,
  success,
  error,
  permissionError,
}

class PrayerTimesState extends Equatable {
  const PrayerTimesState({
    this.status = PrayerTimesStatus.initial,
    this.localPrayerTimes,
    this.nextPrayer,
    this.timeLeft,
    this.previousPrayerDateTime,
    this.message,
    this.lastUpdated,
    this.city,
  });

  final PrayerTimesStatus status;
  final LocalPrayerTimes? localPrayerTimes;
  final String? nextPrayer;
  final Duration? timeLeft;
  final DateTime? previousPrayerDateTime;
  final String? message;
  final DateTime? lastUpdated;
  final String? city;

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
  ];

  PrayerTimesState copyWith({
    PrayerTimesStatus? status,
    LocalPrayerTimes? localPrayerTimes,
    String? nextPrayer,
    Duration? timeLeft,
    DateTime? previousPrayerDateTime,
    String? message,
    DateTime? lastUpdated,
    String? city,
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
  );
}
