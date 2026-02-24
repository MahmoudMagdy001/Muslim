import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/azkar_entity.dart';
import '../repositories/azkar_repository.dart';

class GetAzkarListUseCase implements UseCase<List<AzkarEntity>, NoParams> {
  GetAzkarListUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, List<AzkarEntity>>> call(NoParams params) async =>
      await repository.getAzkarList();
}
