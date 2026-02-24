import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/zikr_entity.dart';

abstract class SebhaRepository {
  Future<Either<Failure, List<ZikrEntity>>> getCustomAzkar();
  Future<Either<Failure, bool>> saveCustomZikr(ZikrEntity zikr);
  Future<Either<Failure, bool>> updateCustomZikr(ZikrEntity zikr);
  Future<Either<Failure, bool>> deleteCustomZikr(String id);
}
