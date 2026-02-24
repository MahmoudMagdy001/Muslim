import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sebha_repository.dart';

class DeleteCustomZikrUseCase implements UseCase<bool, String> {
  DeleteCustomZikrUseCase(this.repository);

  final SebhaRepository repository;

  @override
  Future<Either<Failure, bool>> call(String id) async =>
      repository.deleteCustomZikr(id);
}
