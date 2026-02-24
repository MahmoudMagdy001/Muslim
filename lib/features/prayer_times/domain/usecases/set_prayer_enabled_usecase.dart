import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/prayer_type.dart';
import '../repositories/prayer_notification_repository.dart';

class SetPrayerEnabledParams extends Equatable {
  const SetPrayerEnabledParams({
    required this.prayerType,
    required this.enabled,
  });

  final PrayerType prayerType;
  final bool enabled;

  @override
  List<Object?> get props => [prayerType, enabled];
}

class SetPrayerEnabledUseCase implements UseCase<void, SetPrayerEnabledParams> {
  const SetPrayerEnabledUseCase(this.repository);

  final PrayerNotificationRepository repository;

  @override
  Future<Either<Failure, void>> call(SetPrayerEnabledParams params) async {
    try {
      await repository.setPrayerEnabled(
        params.prayerType,
        enabled: params.enabled,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
