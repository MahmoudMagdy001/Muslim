import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/zakat_repository.dart';
import '../datasources/zakat_remote_data_source.dart';

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
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}
