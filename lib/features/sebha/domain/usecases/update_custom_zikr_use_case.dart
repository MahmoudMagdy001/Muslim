import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/zikr_entity.dart';
import '../repositories/sebha_repository.dart';

class UpdateCustomZikrUseCase implements UseCase<bool, ZikrEntity> {
  UpdateCustomZikrUseCase(this.repository);

  final SebhaRepository repository;

  @override
  Future<Either<Failure, bool>> call(ZikrEntity zikr) async =>
      repository.updateCustomZikr(zikr);
}
