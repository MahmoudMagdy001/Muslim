// prayer_times_state.dart

import '../model/prayer_times_model.dart';

enum PrayerTimesStatus { initial, loading, success, error }

class PrayerTimesState {
  const PrayerTimesState({
    this.status = PrayerTimesStatus.initial,
    this.response,
    this.timings,
    this.nextPrayer,
    this.timeLeft,
    this.message,
  });
  final PrayerTimesStatus status;
  final PrayerTimesResponse? response;
  final Timings? timings;
  final String? nextPrayer;
  final Duration? timeLeft;
  final String? message;

  PrayerTimesState copyWith({
    PrayerTimesStatus? status,
    PrayerTimesResponse? response,
    Timings? timings,
    String? nextPrayer,
    Duration? timeLeft,
    String? message,
  }) => PrayerTimesState(
    status: status ?? this.status,
    response: response ?? this.response,
    timings: timings ?? this.timings,
    nextPrayer: nextPrayer ?? this.nextPrayer,
    timeLeft: timeLeft ?? this.timeLeft,
    message: message ?? this.message,
  );
}
