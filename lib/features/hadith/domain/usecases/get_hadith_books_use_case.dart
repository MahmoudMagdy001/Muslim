import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hadith_book_entity.dart';
import '../repositories/hadith_repository.dart';

class GetHadithBooksUseCase
    implements UseCase<List<HadithBookEntity>, NoParams> {
  const GetHadithBooksUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, List<HadithBookEntity>>> call(NoParams params) async =>
      repository.getHadithBooks();
}
