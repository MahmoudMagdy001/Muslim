import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';

class CancelAllNotificationsUseCase implements UseCase<void, NoParams> {
  const CancelAllNotificationsUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await repository.cancelAllNotifications();
      return const Right(null);
    } on Object catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
