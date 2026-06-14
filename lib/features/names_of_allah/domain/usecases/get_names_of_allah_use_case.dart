import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';

class GetNamesOfAllahUseCase
    implements UseCase<List<NameOfAllahEntity>, NoParams> {
  const GetNamesOfAllahUseCase(this.repository);

  final NamesOfAllahRepository repository;

  @override
  Future<Either<Failure, List<NameOfAllahEntity>>> call(
    NoParams params,
  ) async => repository.getNamesOfAllah();
}
