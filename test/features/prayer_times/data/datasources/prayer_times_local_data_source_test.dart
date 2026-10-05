import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/core/service/location_service.dart';
import 'package:muslim/features/prayer_times/data/datasources/prayer_times_local_data_source.dart';
import 'package:muslim/features/settings/data/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PrayerTimesLocalDataSourceImpl Offline & Fallback Tests', () {
    late SettingsService settingsService;
    late LocationService locationService;

    setUp(() {
      settingsService = SettingsService();
      locationService = LocationService();
    });

    test('returns cached city and prayer times when offline and cache exists', () async {
      SharedPreferences.setMockInitialValues({
        'lat': 31.2001,
        'lng': 29.9187,
        'city_name': 'الإسكندرية',
        'city_name_ar': 'الإسكندرية',
      });

      final dataSource = PrayerTimesLocalDataSourceImpl(
        settingsService: settingsService,
        locationService: locationService,
      );

      final times = await dataSource.getDailyPrayerTimes(
        isArabic: true,
        useLocation: false,
      );

      expect(times.city, 'الإسكندرية');
      expect(times.fajr, isNotEmpty);
      expect(times.dhuhr, isNotEmpty);
      expect(times.asr, isNotEmpty);
      expect(times.maghrib, isNotEmpty);
      expect(times.isha, isNotEmpty);
    });

    test('returns Cairo when offline and cache is completely empty', () async {
      SharedPreferences.setMockInitialValues({});

      final dataSource = PrayerTimesLocalDataSourceImpl(
        settingsService: settingsService,
        locationService: locationService,
      );

      final times = await dataSource.getDailyPrayerTimes(
        isArabic: true,
        useLocation: false,
      );

      expect(times.city, 'القاهرة');
      expect(times.fajr, isNotEmpty);
      expect(times.dhuhr, isNotEmpty);
      expect(times.asr, isNotEmpty);
      expect(times.maghrib, isNotEmpty);
      expect(times.isha, isNotEmpty);
    });

    test('returns English Cairo when offline, isArabic=false, and cache is empty', () async {
      SharedPreferences.setMockInitialValues({});

      final dataSource = PrayerTimesLocalDataSourceImpl(
        settingsService: settingsService,
        locationService: locationService,
      );

      final times = await dataSource.getDailyPrayerTimes(
        isArabic: false,
        useLocation: false,
      );

      expect(times.city, 'Cairo');
      expect(times.fajr, isNotEmpty);
    });
  });
}
