import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/prayer_notification_repository.dart';

class CancelAllNotificationsUseCase implements UseCase<void, NoParams> {
  const CancelAllNotificationsUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await repository.cancelAllNotifications();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
