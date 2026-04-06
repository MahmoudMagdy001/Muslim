import 'package:adhan/adhan.dart';

import '../../domain/entities/local_prayer_times.dart';
import '../../domain/repositories/prayer_times_repository.dart';
import '../datasources/prayer_times_local_data_source.dart';

/// Concrete implementation of [PrayerTimesRepository].
///
/// Delegates to [PrayerTimesLocalDataSource] for all data operations.
class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  PrayerTimesRepositoryImpl({required PrayerTimesLocalDataSource dataSource})
    : _dataSource = dataSource;

  final PrayerTimesLocalDataSource _dataSource;

  @override
  Future<LocalPrayerTimes> getPrayerTimes({
    required bool isArabic,
    bool useLocation = true,
  }) async {
    final result = await _dataSource.getPrayerTimes(
      isArabic: isArabic,
      useLocation: useLocation,
    );
    return result as LocalPrayerTimes;
  }

  @override
  Future<LocalPrayerTimes> getPrayerTimesForDate(
    Coordinates coordinates,
    DateTime date, {
    String? cityName,
  }) async =>
      _dataSource.getPrayerTimesForDate(coordinates, date, cityName: cityName);

  @override
  Future<Coordinates?> getCachedCoordinates() =>
      _dataSource.getCachedCoordinates();
}
