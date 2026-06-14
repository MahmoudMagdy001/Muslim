import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class GetAzkarCountUseCase implements UseCase<int?, GetAzkarCountParams> {
  GetAzkarCountUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, int?>> call(GetAzkarCountParams params) =>
      repository.getAzkarCount(params.sourceUrl, params.index);
}

class GetAzkarCountParams {
  const GetAzkarCountParams({required this.sourceUrl, required this.index});
  final String sourceUrl;
  final int index;
}
