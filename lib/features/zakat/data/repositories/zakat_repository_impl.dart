import 'package:fpdart/fpdart.dart';
import 'package:muslim/core/error/exceptions.dart';
import 'package:muslim/core/error/failures.dart';
import 'package:muslim/features/zakat/data/datasources/zakat_remote_data_source.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZakatRepositoryImpl implements ZakatRepository {
  ZakatRepositoryImpl({
    required this.remoteDataSource,
    SharedPreferences? sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final ZakatRemoteDataSource remoteDataSource;
  final SharedPreferences? _sharedPreferences;

  static const String _cachedGoldPriceKey = 'cached_gold_price_per_gram_egp';

  Future<SharedPreferences> _getPrefs() async =>
      _sharedPreferences ?? await SharedPreferences.getInstance();

  @override
  Future<Either<Failure, double>> getGoldPricePerGramInEgp() async {
    try {
      final goldModel = await remoteDataSource.getGoldPriceInUsd();
      final usdToEgp = await remoteDataSource.getUsdToEgpRate();

      // Convert Ounce to Gram (1 Ounce ≈ 31.1035 Grams)
      const ounceToGram = 31.1035;
      final pricePerGramUsd = goldModel.priceInUsd / ounceToGram;
      final pricePerGramEgp = pricePerGramUsd * usdToEgp;

      if (pricePerGramEgp > 0) {
        final prefs = await _getPrefs();
        await prefs.setDouble(_cachedGoldPriceKey, pricePerGramEgp);
        return Right(pricePerGramEgp);
      }
      throw const ServerException();
    } on Object catch (_) {
      try {
        final prefs = await _getPrefs();
        final cachedPrice = prefs.getDouble(_cachedGoldPriceKey);
        if (cachedPrice != null && cachedPrice > 0) {
          return Right(cachedPrice);
        }
      } on Object catch (_) {
        // Fall through to failure
      }
      return const Left(ServerFailure());
    }
  }
}
