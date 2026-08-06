import 'package:flutter/material.dart';
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

    final savedResult = await repository.getSavedHadiths();
    var savedHadiths = <Map<String, dynamic>>[];
    savedResult.fold((failure) => null, (data) {
      savedHadiths = data;
      for (final h in data) {
        _hadithSavedMap[h['id'].toString()] = ValueNotifier(true);
      }
    });

    final hadithsResult = await repository.getHadithsOfChapter(bookSlug, chapterNumber);

    await hadithsResult.fold(
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
    for (final hadith in hadiths) {
      final id = hadith.id;
      if (!_hadithSavedMap.containsKey(id)) {
        _hadithSavedMap[id] = ValueNotifier(false);
      }
    }
  }

  Future<void> toggleHadithSave(HadithEntity hadith, {required bool isArabic}) async {
    if (_bookSlug == null || _chapterNumber == null || _chapterName == null) {
      return;
    }

    final id = hadith.id;

    if (!_hadithSavedMap.containsKey(id)) {
      _hadithSavedMap[id] = ValueNotifier(false);
    }

    final notifier = _hadithSavedMap[id]!;
    final isCurrentlySaved = notifier.value;

    if (isCurrentlySaved) {
      final result = await repository.removeHadith(id);
      result.fold((failure) => null, (_) {
        notifier.value = false;
      });
    } else {
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
      result.fold((failure) => null, (_) {
        notifier.value = true;
      });
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
