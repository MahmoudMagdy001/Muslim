import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/prayer_notification_settings.dart';
import '../repositories/prayer_notification_repository.dart';

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
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
