import 'package:dartz/dartz.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';

class ZakatRepositoryImpl implements ZakatRepository {
  ZakatRepositoryImpl({required this.remoteDataSource});

  final ZakatRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async {
    try {
      // Fetch both prices concurrently for better performance
      final results = await Future.wait([
        remoteDataSource.getGoldPriceInUsd(),
        remoteDataSource.getUsdToEgpRate(),
      ]);

      final pricePerOunceUsd = results[0];
      final usdToEgp = results[1];

      // Convert Ounce to Gram (1 Ounce ≈ 31.1035 Grams)
      const ounceToGram = 31.1035;
      final pricePerGramUsd = pricePerOunceUsd / ounceToGram;

      final pricePerGramEgp = pricePerGramUsd * usdToEgp;

      return Right(pricePerGramEgp);
    } on ServerException {
      return const Left(ServerFailure());
    } on Object catch (_) {
      return const Left(ServerFailure());
    }
  }
}
