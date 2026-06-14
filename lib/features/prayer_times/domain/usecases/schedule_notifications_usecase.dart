import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/prayer_times/domain/entities/local_prayer_times.dart';
import 'package:muslim/features/prayer_times/domain/repositories/prayer_notification_repository.dart';

class ScheduleNotificationsUseCase
    implements UseCase<void, List<LocalPrayerTimes>> {
  const ScheduleNotificationsUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, void>> call(List<LocalPrayerTimes> params) async {
    try {
      await repository.scheduleNotifications(params);
      return const Right(null);
    } on Object catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
