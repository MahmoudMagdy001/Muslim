import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:muslim/core/error/failures.dart';
import 'package:muslim/core/usecases/usecase.dart';
import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';

class GetHadithsOfChapterUseCase
    implements UseCase<List<HadithEntity>, GetHadithsOfChapterParams> {
  const GetHadithsOfChapterUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, List<HadithEntity>>> call(
    GetHadithsOfChapterParams params,
  ) async =>
      repository.getHadithsOfChapter(params.bookSlug, params.chapterNumber);
}

class GetHadithsOfChapterParams extends Equatable {
  const GetHadithsOfChapterParams({
    required this.bookSlug,
    required this.chapterNumber,
  });

  final String bookSlug;
  final String chapterNumber;

  @override
  List<Object> get props => [bookSlug, chapterNumber];
}
