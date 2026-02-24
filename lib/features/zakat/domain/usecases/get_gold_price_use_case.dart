import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/zakat_repository.dart';

class GetGoldPriceUseCase implements UseCase<double, NoParams> {
  GetGoldPriceUseCase(this.repository);
  final ZakatRepository repository;

  @override
  Future<Either<Failure, double>> call(NoParams params) async =>
      await repository.getGoldPricePerGramInEgp();
}
