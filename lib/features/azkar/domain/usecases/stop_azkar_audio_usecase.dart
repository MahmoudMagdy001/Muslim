import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

class StopAzkarAudioUseCase implements UseCase<void, NoParams> {
  StopAzkarAudioUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) => repository.stopAudio();
}
