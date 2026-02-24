import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

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
