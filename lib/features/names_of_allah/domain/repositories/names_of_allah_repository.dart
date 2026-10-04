import 'package:fpdart/fpdart.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';

abstract class NamesOfAllahRepository {
  Future<Either<Failure, List<NameOfAllahEntity>>> getNamesOfAllah();
}
