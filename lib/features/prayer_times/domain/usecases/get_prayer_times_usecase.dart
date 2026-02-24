import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/local_prayer_times.dart';
import '../repositories/prayer_times_repository.dart';

class GetPrayerTimesUseCase implements UseCase<LocalPrayerTimes, bool> {
  const GetPrayerTimesUseCase(this.repository);

  final PrayerTimesRepository repository;

  @override
  Future<Either<Failure, LocalPrayerTimes>> call(bool isArabic) async {
    try {
      final result = await repository.getPrayerTimes(isArabic: isArabic);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
