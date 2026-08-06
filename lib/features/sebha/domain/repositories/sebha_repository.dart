import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';

abstract class SebhaRepository {
  Future<Either<Failure, List<ZikrEntity>>> getCustomAzkar();
  Future<Either<Failure, bool>> saveCustomZikr(ZikrEntity zikr);
  Future<Either<Failure, bool>> updateCustomZikr(ZikrEntity zikr);
  Future<Either<Failure, bool>> deleteCustomZikr(String id);
  // ponytail: progress is pure local state, no Either needed
  Future<void> saveProgress(String zikrId, int counter);
  Future<int> loadProgress(String zikrId);
}
