import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zikr_entity.dart';
import '../repositories/sebha_repository.dart';

class GetCustomAzkarUseCase implements UseCase<List<ZikrEntity>, NoParams> {
  GetCustomAzkarUseCase(this.repository);

  final SebhaRepository repository;

  @override
  Future<Either<Failure, List<ZikrEntity>>> call(NoParams params) async =>
      repository.getCustomAzkar();
}
