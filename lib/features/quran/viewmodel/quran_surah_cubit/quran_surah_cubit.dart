import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../repository/quran_repository.dart';
import 'quran_surah_state.dart';

class QuranSurahCubit extends Cubit<QuranSurahState> {
  QuranSurahCubit(this._repository) : super(const QuranSurahState());

  final QuranRepository _repository;
  static int? _lastLoadedSurah;
  static String? _lastLoadedReciter;

  Future<void> loadSurah(
    int surahNumber,
    String reciter, {
    int startAyah = 1,
  }) async {
    if (_isSameSurahAndReciter(surahNumber, reciter)) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.alreadyLoaded,
          surahNumber: state.surahNumber ?? surahNumber,
        ),
      );
      if (startAyah > 1) {
        // عمل seek للصوت من الآية
        await _repository.seek(Duration.zero, index: startAyah - 1);
      }
      return;
    }

    emit(
      state.copyWith(
        status: QuranSurahStatus.loading,
        surahNumber: surahNumber,
      ),
    );

    try {
      final bool hasIntroBasmala = surahNumber != 1 && surahNumber != 9;

      await _repository.prepareSurahPlaylist(
        surahNumber: surahNumber,
        reciter: reciter,
        includeBasmala: hasIntroBasmala,
      );

      _updateLastLoadedInfo(surahNumber, reciter);

      emit(
        state.copyWith(
          status: QuranSurahStatus.loaded,
          surahNumber: surahNumber,
          ayahCount: quran.getVerseCount(surahNumber),
          startAyah: startAyah,
          hasIntroBasmala: hasIntroBasmala,
        ),
      );

      if (startAyah > 1) {
        await _repository.seek(Duration.zero, index: startAyah - 1);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.error,
          message: e.toString(),
          surahNumber: surahNumber,
        ),
      );
    }
  }

  bool _isSameSurahAndReciter(int surahNumber, String reciter) =>
      _lastLoadedSurah == surahNumber && _lastLoadedReciter == reciter;

  void _updateLastLoadedInfo(int surahNumber, String reciter) {
    _lastLoadedSurah = surahNumber;
    _lastLoadedReciter = reciter;
  }
}
