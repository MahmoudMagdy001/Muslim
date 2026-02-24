import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hadith_entity.dart';
import '../repositories/hadith_repository.dart';

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
