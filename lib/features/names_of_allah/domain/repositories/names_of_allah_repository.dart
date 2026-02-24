import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/name_of_allah_entity.dart';

abstract class NamesOfAllahRepository {
  Future<Either<Failure, List<NameOfAllahEntity>>> getNamesOfAllah();
}
