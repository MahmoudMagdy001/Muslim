import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/zakat/domain/repositories/zakat_repository.dart';

class GetGoldPriceUseCase implements UseCase<double, NoParams> {
  GetGoldPriceUseCase(this.repository);
  final ZakatRepository repository;

  @override
  Future<Either<Failure, double>> call(NoParams params) async =>
      repository.getGoldPricePerGramInEgp();
}
