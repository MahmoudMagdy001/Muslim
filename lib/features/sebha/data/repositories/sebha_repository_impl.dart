import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/zikr_entity.dart';
import '../../domain/repositories/sebha_repository.dart';
import '../datasources/sebha_local_data_source.dart';
import '../models/zikr_model.dart';

class SebhaRepositoryImpl implements SebhaRepository {
  SebhaRepositoryImpl({required this.localDataSource});

  final SebhaLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<ZikrEntity>>> getCustomAzkar() async {
    try {
      final customAzkar = await localDataSource.getCustomAzkar();
      return Right(customAzkar);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveCustomZikr(ZikrEntity zikr) async {
    try {
      final zikrModel = ZikrModel.fromEntity(zikr);
      final result = await localDataSource.saveCustomZikr(zikrModel);
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateCustomZikr(ZikrEntity zikr) async {
    try {
      final zikrModel = ZikrModel.fromEntity(zikr);
      final result = await localDataSource.updateCustomZikr(zikrModel);
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCustomZikr(String id) async {
    try {
      final result = await localDataSource.deleteCustomZikr(id);
      return Right(result);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
