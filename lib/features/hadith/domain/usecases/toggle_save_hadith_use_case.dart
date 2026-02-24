import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/hadith_entity.dart';
import '../repositories/hadith_repository.dart';

class ToggleSaveHadithUseCase implements UseCase<void, ToggleSaveHadithParams> {
  const ToggleSaveHadithUseCase(this.repository);
  final HadithRepository repository;

  @override
  Future<Either<Failure, void>> call(ToggleSaveHadithParams params) async {
    if (params.isCurrentlySaved) {
      return repository.removeHadith(params.hadith.id);
    } else {
      final data = {
        'id': params.hadith.id,
        'heading': params.isArabic
            ? params.hadith.headingArabic
            : params.hadith.headingEnglish,
        'text': params.isArabic
            ? params.hadith.hadithArabic
            : params.hadith.hadithEnglish,
        'status': params.isArabic
            ? _getStatus(params.hadith.status, true)
            : params.hadith.status,
        'bookSlug': params.bookSlug,
        'chapterNumber': params.chapterNumber,
        'chapterName': params.chapterName,
      };
      return repository.saveHadith(data);
    }
  }

  String _getStatus(String status, bool isArabic) {
    const statusMap = {
      'Sahih': 'صحيح',
      'sahih': 'صحيح',
      'Hasan': 'حسن',
      'hasan': 'حسن',
      'Da`eef': 'ضعيف',
      'da`eef': 'ضعيف',
    };
    return isArabic ? statusMap[status] ?? status : status;
  }
}

class ToggleSaveHadithParams extends Equatable {
  const ToggleSaveHadithParams({
    required this.hadith,
    required this.isArabic,
    required this.isCurrentlySaved,
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
  });

  final HadithEntity hadith;
  final bool isArabic;
  final bool isCurrentlySaved;
  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  @override
  List<Object> get props => [
    hadith,
    isArabic,
    isCurrentlySaved,
    bookSlug,
    chapterNumber,
    chapterName,
  ];
}
