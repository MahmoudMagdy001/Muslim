import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/name_of_allah_entity.dart';
import '../repositories/names_of_allah_repository.dart';

class GetNamesOfAllahUseCase
    implements UseCase<List<NameOfAllahEntity>, NoParams> {
  const GetNamesOfAllahUseCase(this.repository);

  final NamesOfAllahRepository repository;

  @override
  Future<Either<Failure, List<NameOfAllahEntity>>> call(
    NoParams params,
  ) async => await repository.getNamesOfAllah();
}
