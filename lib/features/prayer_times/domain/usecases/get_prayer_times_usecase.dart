import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';

class GetPrayerTimesParams {
  const GetPrayerTimesParams({required this.isArabic, this.useLocation = true});
  final bool isArabic;
  final bool useLocation;
}

class GetPrayerTimesUseCase
    implements UseCase<LocalPrayerTimes, GetPrayerTimesParams> {
  const GetPrayerTimesUseCase(this.repository);

  final PrayerTimesRepository repository;

  @override
  Future<Either<Failure, LocalPrayerTimes>> call(
    GetPrayerTimesParams params,
  ) async {
    try {
      final result = await repository.getPrayerTimes(
        isArabic: params.isArabic,
        useLocation: params.useLocation,
      );
      return Right(result);
    } on Object catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
