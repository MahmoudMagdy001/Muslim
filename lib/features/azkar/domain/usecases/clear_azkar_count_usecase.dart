import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class ClearAzkarCountUseCase implements UseCase<void, NoParams> {
  ClearAzkarCountUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      repository.clearAzkarCountIfNewDay();
}
