import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';

class GetCustomAzkarUseCase implements UseCase<List<ZikrEntity>, NoParams> {
  GetCustomAzkarUseCase(this.repository);

  final SebhaRepository repository;

  @override
  Future<Either<Failure, List<ZikrEntity>>> call(NoParams params) async =>
      repository.getCustomAzkar();
}
