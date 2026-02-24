import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/hadith_repository.dart';

class GetSavedHadithsUseCase
    implements UseCase<List<Map<String, dynamic>>, NoParams> {
  const GetSavedHadithsUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
    NoParams params,
  ) async => repository.getSavedHadiths();
}
