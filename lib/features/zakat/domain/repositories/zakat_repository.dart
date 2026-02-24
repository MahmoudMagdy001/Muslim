import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ZakatRepository {
  /// Fetches the current gold price per gram in EGP.
  Future<Either<Failure, double>> getGoldPricePerGramInEgp();
}
