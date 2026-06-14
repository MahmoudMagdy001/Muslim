import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_entity.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class GetAzkarListUseCase implements UseCase<List<AzkarEntity>, NoParams> {
  GetAzkarListUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, List<AzkarEntity>>> call(NoParams params) async =>
      repository.getAzkarList();
}
