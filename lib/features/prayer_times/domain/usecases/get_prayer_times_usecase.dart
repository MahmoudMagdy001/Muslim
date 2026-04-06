import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/local_prayer_times.dart';
import '../repositories/prayer_times_repository.dart';

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
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
