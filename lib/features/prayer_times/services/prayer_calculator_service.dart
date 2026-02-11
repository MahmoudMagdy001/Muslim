import 'package:intl/intl.dart';

import '../model/prayer_calculation_result_model.dart';
import '../model/prayer_times_model.dart';
import '../models/prayer_type.dart';

/// Service for calculating the next/previous prayer and time remaining.
class PrayerCalculatorService {
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// Calculates next prayer, previous prayer, and time remaining.
  PrayerCalculationResult calculateNextPrayer(LocalPrayerTimes times) {
    final now = DateTime.now();
    final nextPrayer = _getNextPrayerType(times, now);
    final nextPrayerDateTime = _getNextPrayerDateTime(times, nextPrayer, now);
    final previousPrayer = _getPreviousPrayerType(times, now);
    final previousPrayerDateTime = _getPreviousPrayerDateTime(
      times,
      previousPrayer,
      now,
    );
    final timeLeft = nextPrayerDateTime.difference(now);

    return PrayerCalculationResult(
      nextPrayer: nextPrayer,
      nextPrayerDateTime: nextPrayerDateTime,
      previousPrayerDateTime: previousPrayerDateTime,
      timeLeft: timeLeft,
      areAllPrayersFinished: _areAllPrayersFinished(times, now),
    );
  }

  /// Gets the next prayer type based on current time.
  PrayerType _getNextPrayerType(LocalPrayerTimes times, DateTime now) {
    for (final prayer in PrayerType.values) {
      final timeStr = times.timeForPrayer(prayer);
      if (timeStr == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(timeStr, now);
      if (prayerDateTime.isAfter(now)) return prayer;
    }

    return PrayerType.fajr;
  }

  /// Gets the previous prayer type based on current time.
  PrayerType _getPreviousPrayerType(LocalPrayerTimes times, DateTime now) {
    for (final prayer in PrayerType.values.reversed) {
      final timeStr = times.timeForPrayer(prayer);
      if (timeStr == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(timeStr, now);
      if (prayerDateTime.isBefore(now)) return prayer;
    }

    return PrayerType.isha;
  }

  /// Gets the DateTime of the next prayer.
  DateTime _getNextPrayerDateTime(
    LocalPrayerTimes times,
    PrayerType prayer,
    DateTime now,
  ) {
    final timeStr = times.timeForPrayer(prayer);
    final areAllFinished = _areAllPrayersFinished(times, now);

    if (prayer == PrayerType.fajr && areAllFinished) {
      final parsedTime = _timeFormat.parse(timeStr);
      return DateTime(
        now.year,
        now.month,
        now.day + 1,
        parsedTime.hour,
        parsedTime.minute,
      );
    }

    final parsedTime = _timeFormat.parse(timeStr);
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  /// Gets the DateTime of the previous prayer.
  DateTime _getPreviousPrayerDateTime(
    LocalPrayerTimes times,
    PrayerType prayer,
    DateTime now,
  ) {
    final timeStr = times.timeForPrayer(prayer);
    final isFajrNext = _getNextPrayerType(times, now) == PrayerType.fajr;
    final areAllFinished = _areAllPrayersFinished(times, now);

    if (prayer == PrayerType.isha && isFajrNext && !areAllFinished) {
      final parsedTime = _timeFormat.parse(timeStr);
      return DateTime(
        now.year,
        now.month,
        now.day - 1,
        parsedTime.hour,
        parsedTime.minute,
      );
    }

    final parsedTime = _timeFormat.parse(timeStr);
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  /// Checks if all prayers have passed for today.
  bool _areAllPrayersFinished(LocalPrayerTimes times, DateTime now) {
    for (final prayer in PrayerType.values) {
      final timeStr = times.timeForPrayer(prayer);
      if (timeStr == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(timeStr, now);
      if (prayerDateTime.isAfter(now)) return false;
    }
    return true;
  }

  DateTime _parsePrayerTime(String timeString, DateTime referenceDate) {
    final parsed = _timeFormat.parse(timeString);
    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      parsed.hour,
      parsed.minute,
    );
  }
}
