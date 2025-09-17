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

  Future<void> loadSurah(int surahNumber, String reciter) async {
    if (_isSameSurahAndReciter(surahNumber, reciter)) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.alreadyLoaded,
          surahNumber: state.surahNumber ?? surahNumber,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: QuranSurahStatus.loading,
        surahNumber: surahNumber,
      ),
    );

    try {
      final lastRead = await _repository.loadLastRead();
      int startAyah = 1;
      if (lastRead['surah'] == surahNumber && lastRead['ayah'] != null) {
        startAyah = lastRead['ayah'];
      }

      await _repository.prepareSurahPlaylist(
        surahNumber: surahNumber,
        reciter: reciter,
      );

      _updateLastLoadedInfo(surahNumber, reciter);

      emit(
        state.copyWith(
          status: QuranSurahStatus.loaded,
          surahNumber: surahNumber,
          ayahCount: quran.getVerseCount(surahNumber),
          startAyah: startAyah,
        ),
      );

      await _repository.seek(Duration.zero, index: startAyah - 1);
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

  Future<void> resumeLastRead(String reciter) async {
    final lastRead = await _repository.loadLastRead();
    if (lastRead['surah'] != null && lastRead['ayah'] != null) {
      await loadSurah(lastRead['surah']!, reciter);
    }
  }
}
