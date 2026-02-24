import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/azkar_repository.dart';

class SaveAzkarCountUseCase implements UseCase<void, SaveAzkarCountParams> {
  SaveAzkarCountUseCase(this.repository);
  final AzkarRepository repository;

  @override
  Future<Either<Failure, void>> call(SaveAzkarCountParams params) =>
      repository.saveAzkarCount(params.sourceUrl, params.index, params.count);
}

class SaveAzkarCountParams {
  const SaveAzkarCountParams({
    required this.sourceUrl,
    required this.index,
    required this.count,
  });
  final String sourceUrl;
  final int index;
  final int count;
}
