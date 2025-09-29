import 'package:intl/intl.dart';

import '../helper/prayer_consts.dart';
import '../model/prayer_calculation_result_model.dart';
import '../model/prayer_times_model.dart';

class PrayerCalculatorService {
  final DateFormat _timeFormat = DateFormat('HH:mm');

  /// حساب الصلاة التالية
  PrayerCalculationResult calculateNextPrayer(LocalPrayerTimes times) {
    final now = DateTime.now();
    final nextPrayerName = _getNextPrayerName(times, now);
    final nextPrayerDateTime = _getNextPrayerDateTime(
      times,
      nextPrayerName,
      now,
    );
    final timeLeft = nextPrayerDateTime.difference(now);

    return PrayerCalculationResult(
      nextPrayer: nextPrayerName,
      nextPrayerDateTime: nextPrayerDateTime,
      timeLeft: timeLeft,
      areAllPrayersFinished: _areAllPrayersFinished(times, now),
    );
  }

  /// الحصول على اسم الصلاة التالية
  String _getNextPrayerName(LocalPrayerTimes times, DateTime now) {
    final timingsMap = times.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      if (prayerTime == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(prayerTime, now);
      if (prayerDateTime.isAfter(now)) return prayer;
    }

    return 'Fajr';
  }

  /// الحصول على وقت الصلاة التالية
  DateTime _getNextPrayerDateTime(
    LocalPrayerTimes times,
    String prayerName,
    DateTime now,
  ) {
    final timingsMap = times.toMap();
    final prayerTime = timingsMap[prayerName]!;
    final areAllPrayersFinished = _areAllPrayersFinished(times, now);

    if (prayerName == 'Fajr' && areAllPrayersFinished) {
      final parsedTime = _timeFormat.parse(prayerTime);
      return DateTime(
        now.year,
        now.month,
        now.day + 1,
        parsedTime.hour,
        parsedTime.minute,
      );
    }

    final parsedTime = _timeFormat.parse(prayerTime);
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  /// التحقق إذا انتهت جميع صلوات اليوم
  bool _areAllPrayersFinished(LocalPrayerTimes times, DateTime now) {
    final timingsMap = times.toMap();

    for (final prayer in prayerOrder) {
      final prayerTime = timingsMap[prayer]!;
      if (prayerTime == '--:--') continue;

      final prayerDateTime = _parsePrayerTime(prayerTime, now);
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
