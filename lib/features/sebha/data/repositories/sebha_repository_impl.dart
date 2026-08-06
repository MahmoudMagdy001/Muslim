import 'package:dartz/dartz.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/sebha/data/datasources/sebha_local_data_source.dart';
import 'package:muslim/features/sebha/data/models/zikr_model.dart';
import 'package:muslim/features/sebha/domain/entities/zikr_entity.dart';
import 'package:muslim/features/sebha/domain/repositories/sebha_repository.dart';

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
    } on Object catch (_) {
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
    } on Object catch (_) {
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
    } on Object catch (_) {
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
    } on Object catch (_) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<void> saveProgress(String zikrId, int counter) =>
      localDataSource.saveProgress(zikrId, counter);

  @override
  Future<int> loadProgress(String zikrId) =>
      localDataSource.loadProgress(zikrId);
}
