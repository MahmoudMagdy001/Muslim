import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/hadith_repository.dart';

class GetRandomHadithUseCase
    implements UseCase<Map<String, dynamic>, NoParams> {
  const GetRandomHadithUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async =>
      repository.getRandomHadith();
}
