import 'package:dartz/dartz.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/names_of_allah/data/datasources/names_of_allah_local_data_source.dart';
import 'package:muslim/features/names_of_allah/domain/entities/name_of_allah_entity.dart';
import 'package:muslim/features/names_of_allah/domain/repositories/names_of_allah_repository.dart';

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
