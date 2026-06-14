import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/prayer_times/domain/entities/prayer_notification_settings.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';

class GetNotificationSettingsUseCase
    implements UseCase<PrayerNotificationSettings, NoParams> {
  const GetNotificationSettingsUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, PrayerNotificationSettings>> call(
    NoParams params,
  ) async {
    try {
      final result = await repository.getSettings();
      return Right(result);
    } on Object catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
