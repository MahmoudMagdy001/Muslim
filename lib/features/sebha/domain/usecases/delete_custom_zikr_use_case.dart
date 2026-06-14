import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';

class DeleteCustomZikrUseCase implements UseCase<bool, String> {
  DeleteCustomZikrUseCase(this.repository);

  final SebhaRepository repository;

  @override
  Future<Either<Failure, bool>> call(String id) async =>
      repository.deleteCustomZikr(id);
}
