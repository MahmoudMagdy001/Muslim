import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/prayer_times_repository.dart';

class GetCachedCoordinatesUseCase implements UseCase<Coordinates?, NoParams> {
  const GetCachedCoordinatesUseCase(this.repository);

  final PrayerTimesRepository repository;

  @override
  Future<Either<Failure, Coordinates?>> call(NoParams params) async {
    try {
      final result = await repository.getCachedCoordinates();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
