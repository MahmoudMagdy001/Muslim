import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/local_prayer_times.dart';
import '../repositories/prayer_notification_repository.dart';

class ScheduleNotificationsUseCase
    implements UseCase<void, List<LocalPrayerTimes>> {
  const ScheduleNotificationsUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, void>> call(List<LocalPrayerTimes> params) async {
    try {
      await repository.scheduleNotifications(params);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
