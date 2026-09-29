import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/hadith/domain/entities/hadith_entity.dart';
import 'package:muslim/features/hadith/domain/repositories/hadith_repository.dart';
import 'package:muslim/features/hadith/presentation/cubit/hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit({
    required this.repository,
  }) : super(const HadithState());

  final HadithRepository repository;

  String? _bookSlug;
  String? _chapterNumber;
  String? _chapterName;

  bool isHadithSaved(String hadithId) =>
      state.savedHadithIds.contains(hadithId);

  Future<void> initializeData(
    String bookSlug,
    String chapterNumber,
    String chapterName,
  ) async {
    _bookSlug = bookSlug;
    _chapterNumber = chapterNumber;
    _chapterName = chapterName;

    if (!isClosed) emit(state.copyWith(status: HadithStatus.loading));

    final savedResult = await repository.getSavedHadiths();
    var savedHadiths = <Map<String, dynamic>>[];
    final savedIds = <String>{};

    savedResult.fold((failure) => null, (data) {
      savedHadiths = data;
      for (final h in data) {
        final id = h['id']?.toString();
        if (id != null) savedIds.add(id);
      }
    });

    final hadithsResult = await repository.getHadithsOfChapter(bookSlug, chapterNumber);

    hadithsResult.fold(
      (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: HadithStatus.error,
              message: 'Failed to load hadiths',
            ),
          );
        }
      },
      (hadiths) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: HadithStatus.success,
              hadiths: hadiths,
              savedHadiths: savedHadiths,
              savedHadithIds: savedIds,
              dataLoaded: true,
            ),
          );
        }
      },
    );
  }

  Future<void> reloadData() async {
    if (_bookSlug != null && _chapterNumber != null && _chapterName != null) {
      await initializeData(_bookSlug!, _chapterNumber!, _chapterName!);
    }
  }

  Future<void> toggleHadithSave(HadithEntity hadith, {required bool isArabic}) async {
    if (_bookSlug == null || _chapterNumber == null || _chapterName == null) {
      return;
    }

    final id = hadith.id;
    final isCurrentlySaved = isHadithSaved(id);
    final previousSavedIds = Set<String>.from(state.savedHadithIds);
    final updatedIds = Set<String>.from(state.savedHadithIds);

    if (isCurrentlySaved) {
      updatedIds.remove(id);
      if (!isClosed) emit(state.copyWith(savedHadithIds: updatedIds));

      final result = await repository.removeHadith(id);
      result.fold(
        (failure) {
          if (!isClosed) emit(state.copyWith(savedHadithIds: previousSavedIds));
        },
        (_) => null,
      );
    } else {
      updatedIds.add(id);
      if (!isClosed) emit(state.copyWith(savedHadithIds: updatedIds));

      final data = {
        'id': id,
        'heading': isArabic
            ? hadith.headingArabic
            : hadith.headingEnglish,
        'text': isArabic
            ? hadith.hadithArabic
            : hadith.hadithEnglish,
        'status': isArabic
            ? getStatus(hadith.status)
            : hadith.status,
        'bookSlug': _bookSlug!,
        'chapterNumber': _chapterNumber!,
        'chapterName': _chapterName!,
      };

      final result = await repository.saveHadith(data);
      result.fold(
        (failure) {
          if (!isClosed) emit(state.copyWith(savedHadithIds: previousSavedIds));
        },
        (_) => null,
      );
    }
  }

  static const Map<String, String> _statusMap = {
    'Sahih': 'صحيح',
    'sahih': 'صحيح',
    'Hasan': 'حسن',
    'hasan': 'حسن',
    'Da`eef': 'ضعيف',
    'da`eef': 'ضعيف',
  };

  String getStatus(String status, {bool isArabic = true}) =>
      isArabic ? _statusMap[status] ?? status : status;
}
