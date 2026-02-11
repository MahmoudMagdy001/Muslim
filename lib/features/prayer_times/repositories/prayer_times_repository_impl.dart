import 'package:adhan/adhan.dart';

import '../model/prayer_times_model.dart';
import '../services/prayer_times_service.dart';
import 'prayer_times_repository.dart';

/// Concrete implementation of [PrayerTimesRepository].
///
/// Delegates to [PrayerTimesService] for all data operations.
class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  PrayerTimesRepositoryImpl({required PrayerTimesService service})
    : _service = service;

  final PrayerTimesService _service;

  @override
  Future<LocalPrayerTimes> getPrayerTimes({required bool isArabic}) async {
    final result = await _service.getPrayerTimes(isArabic: isArabic);
    return result as LocalPrayerTimes;
  }

  @override
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  }) async =>
      _service.getPrayerTimesForDate(coordinates, date, cityName: cityName);

  @override
  Future<Coordinates?> getCachedCoordinates() =>
      _service.getCachedCoordinates();
}
