import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';

class GetRandomHadithUseCase
    implements UseCase<Map<String, dynamic>, NoParams> {
  const GetRandomHadithUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async =>
      repository.getRandomHadith();
}
