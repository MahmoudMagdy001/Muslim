import 'package:flutter_test/flutter_test.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_type.dart';
import 'package:muslim/features/prayer_times/domain/usecases/calculate_next_prayer_usecase.dart';

void main() {
  late CalculateNextPrayerUseCase useCase;

  setUp(() {
    useCase = CalculateNextPrayerUseCase();
  });

  group('CalculateNextPrayerUseCase Tests', () {
    test('calculateSync calculates prayer times and next prayer correctly', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // Create prayer times with mock future times
      final times = LocalPrayerTimes(
        fajr: '04:30',
        sunrise: '06:00',
        dhuhr: '12:30',
        asr: '15:45',
        maghrib: '18:20',
        isha: '20:00',
        city: 'Cairo',
        date: today,
        fajrDateTime: today.add(const Duration(hours: 4, minutes: 30)),
        sunriseDateTime: today.add(const Duration(hours: 6)),
        dhuhrDateTime: today.add(const Duration(hours: 12, minutes: 30)),
        asrDateTime: today.add(const Duration(hours: 15, minutes: 45)),
        maghribDateTime: today.add(const Duration(hours: 18, minutes: 20)),
        ishaDateTime: today.add(const Duration(hours: 20)),
      );

      final result = useCase.calculateSync(times);

      expect(result.nextPrayer, isA<PrayerType>());
      expect(result.nextPrayerDateTime, isNotNull);
      expect(result.timeLeft, isNotNull);
    });

    test('async call returns Right(PrayerCalculationResult)', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final times = LocalPrayerTimes(
        fajr: '04:30',
        sunrise: '06:00',
        dhuhr: '12:30',
        asr: '15:45',
        maghrib: '18:20',
        isha: '20:00',
        city: 'Cairo',
        date: today,
      );

      final resultEither = await useCase(times);

      expect(resultEither.isRight(), isTrue);
      resultEither.fold((failure) => fail('Should not return failure'), (result) {
        expect(result.nextPrayer, isA<PrayerType>());
        expect(result.nextPrayerDateTime, isNotNull);
      });
    });
  });
}
