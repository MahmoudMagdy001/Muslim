import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';

part 'prayer_calculation_result.freezed.dart';

@freezed
abstract class PrayerCalculationResult with _$PrayerCalculationResult {
  const factory PrayerCalculationResult({
    required PrayerType nextPrayer,
    required DateTime nextPrayerDateTime,
    required DateTime previousPrayerDateTime,
    required Duration timeLeft,
    required bool areAllPrayersFinished,
  }) = _PrayerCalculationResult;
}
