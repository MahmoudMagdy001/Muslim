import 'package:adhan/adhan.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_times_repository.dart';

class GetPrayerTimesForDateParams extends Equatable {
  const GetPrayerTimesForDateParams({
    required this.coordinates,
    required this.date,
    this.cityName,
  });

  final Coordinates coordinates;
  final DateTime date;
  final String? cityName;

  @override
  List<Object?> get props => [coordinates, date, cityName];
}

class GetPrayerTimesForDateUseCase
    implements UseCase<LocalPrayerTimes, GetPrayerTimesForDateParams> {
  const GetPrayerTimesForDateUseCase(this.repository);

  final PrayerTimesRepository repository;

  @override
  Future<Either<Failure, LocalPrayerTimes>> call(
    GetPrayerTimesForDateParams params,
  ) async {
    try {
      final result = await repository.getPrayerTimesForDate(
        params.coordinates,
        params.date,
        cityName: params.cityName,
      );
      return Right(result);
    } on Object catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
