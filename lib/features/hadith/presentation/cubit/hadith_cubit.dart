import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/hadith_entity.dart';
import '../../domain/usecases/get_hadiths_of_chapter_use_case.dart';
import '../../domain/usecases/get_saved_hadiths_use_case.dart';
import '../../domain/usecases/toggle_save_hadith_use_case.dart';
import 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  HadithCubit({
    required this.getHadithsOfChapterUseCase,
    required this.getSavedHadithsUseCase,
    required this.toggleSaveHadithUseCase,
  }) : super(const HadithState());

  final GetHadithsOfChapterUseCase getHadithsOfChapterUseCase;
  final GetSavedHadithsUseCase getSavedHadithsUseCase;
  final ToggleSaveHadithUseCase toggleSaveHadithUseCase;

  String? _bookSlug;
  String? _chapterNumber;
  String? _chapterName;

  final Map<String, ValueNotifier<bool>> _hadithSavedMap = {};

  bool isHadithSaved(String hadithId) =>
      _hadithSavedMap[hadithId]?.value ?? false;

  ValueNotifier<bool>? getHadithNotifier(String hadithId) =>
      _hadithSavedMap[hadithId];

  Future<void> initializeData(
    String bookSlug,
    String chapterNumber,
    String chapterName,
  ) async {
    _bookSlug = bookSlug;
    _chapterNumber = chapterNumber;
    _chapterName = chapterName;

    if (!isClosed) emit(state.copyWith(status: HadithStatus.loading));

    final savedResult = await getSavedHadithsUseCase(NoParams());
    List<Map<String, dynamic>> savedHadiths = [];
    savedResult.fold((failure) => null, (data) {
      savedHadiths = data;
      for (final h in data) {
        _hadithSavedMap[h['id'].toString()] = ValueNotifier(true);
      }
    });

    final hadithsResult = await getHadithsOfChapterUseCase(
      GetHadithsOfChapterParams(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
      ),
    );

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
      (hadiths) async {
        await _prepareHadithData(hadiths);
        if (!isClosed) {
          emit(
            state.copyWith(
              status: HadithStatus.success,
              hadiths: hadiths,
              savedHadiths: savedHadiths,
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

  Future<void> _prepareHadithData(List<HadithEntity> hadiths) async {
    for (var hadith in hadiths) {
      final id = hadith.id;
      if (!_hadithSavedMap.containsKey(id)) {
        _hadithSavedMap[id] = ValueNotifier(false);
      }
    }
  }

  Future<void> toggleHadithSave(HadithEntity hadith, bool isArabic) async {
    if (_bookSlug == null || _chapterNumber == null || _chapterName == null) {
      return;
    }

    final id = hadith.id;

    if (!_hadithSavedMap.containsKey(id)) {
      _hadithSavedMap[id] = ValueNotifier(false);
    }

    final notifier = _hadithSavedMap[id]!;
    final isCurrentlySaved = notifier.value;

    final result = await toggleSaveHadithUseCase(
      ToggleSaveHadithParams(
        hadith: hadith,
        isArabic: isArabic,
        isCurrentlySaved: isCurrentlySaved,
        bookSlug: _bookSlug!,
        chapterNumber: _chapterNumber!,
        chapterName: _chapterName!,
      ),
    );

    result.fold((failure) => null, (_) {
      notifier.value = !isCurrentlySaved;
    });
  }

  static const Map<String, String> _statusMap = {
    'Sahih': 'صحيح',
    'sahih': 'صحيح',
    'Hasan': 'حسن',
    'hasan': 'حسن',
    'Da`eef': 'ضعيف',
    'da`eef': 'ضعيف',
  };

  String getStatus(String status, bool isArabic) =>
      isArabic ? _statusMap[status] ?? status : status;
}
