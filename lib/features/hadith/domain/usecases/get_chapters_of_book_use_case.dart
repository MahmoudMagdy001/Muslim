import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/hadith/domain/entities/chapter_of_book_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';

class GetChaptersOfBookUseCase
    implements UseCase<List<ChapterOfBookEntity>, GetChaptersOfBookParams> {
  const GetChaptersOfBookUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, List<ChapterOfBookEntity>>> call(
    GetChaptersOfBookParams params,
  ) async => repository.getChaptersOfBook(params.bookSlug);
}

class GetChaptersOfBookParams extends Equatable {
  const GetChaptersOfBookParams({required this.bookSlug});
  final String bookSlug;

  @override
  List<Object> get props => [bookSlug];
}
