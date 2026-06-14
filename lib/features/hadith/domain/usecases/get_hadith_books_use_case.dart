import 'package:dartz/dartz.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_book_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';

class GetHadithBooksUseCase
    implements UseCase<List<HadithBookEntity>, NoParams> {
  const GetHadithBooksUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, List<HadithBookEntity>>> call(NoParams params) async =>
      repository.getHadithBooks();
}
