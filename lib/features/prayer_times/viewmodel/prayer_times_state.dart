import '../model/prayer_times_model.dart';

enum PrayerTimesStatus { initial, loading, success, error }

class PrayerTimesState {
  const PrayerTimesState({
    this.status = PrayerTimesStatus.initial,
    this.localPrayerTimes,
    this.nextPrayer,
    this.timeLeft,
    this.message,
    this.lastUpdated,
  });

  final PrayerTimesStatus status;
  final LocalPrayerTimes? localPrayerTimes;
  final String? nextPrayer;
  final Duration? timeLeft;
  final String? message;
  final DateTime? lastUpdated;

  PrayerTimesState copyWith({
    PrayerTimesStatus? status,
    LocalPrayerTimes? localPrayerTimes,
    String? nextPrayer,
    Duration? timeLeft,
    String? message,
    DateTime? lastUpdated,
  }) => PrayerTimesState(
    status: status ?? this.status,
    localPrayerTimes: localPrayerTimes ?? this.localPrayerTimes,
    nextPrayer: nextPrayer ?? this.nextPrayer,
    timeLeft: timeLeft ?? this.timeLeft,
    message: message ?? this.message,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
}
