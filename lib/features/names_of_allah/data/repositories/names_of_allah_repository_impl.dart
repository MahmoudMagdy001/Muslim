import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/name_of_allah_entity.dart';
import '../../domain/repositories/names_of_allah_repository.dart';
import '../datasources/names_of_allah_local_data_source.dart';

class NamesOfAllahRepositoryImpl implements NamesOfAllahRepository {
  const NamesOfAllahRepositoryImpl({required this.localDataSource});

  final NamesOfAllahLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<NameOfAllahEntity>>> getNamesOfAllah() async {
    try {
      final localNames = await localDataSource.getNamesOfAllah();
      return Right(localNames);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
