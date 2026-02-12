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

  /// تحميل سورة معينة مع اختيار القارئ والآية الابتدائية.
  Future<void> loadSurah(
    int surahNumber,
    String reciter, {
    int startAyah = 1,
  }) async {
    final isSameSurah = _isSameSurahAndReciter(surahNumber, reciter);

    if (isSameSurah) {
      _emitAlreadyLoaded(surahNumber);
      await _seekToAyahIfNeeded(startAyah);
      return;
    }

    if (!isClosed) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.loading,
          surahNumber: surahNumber,
        ),
      );
    }

    try {
      await _prepareAndEmitLoaded(surahNumber, reciter, startAyah);
    } catch (e) {
      _emitError(surahNumber, e);
    }
  }

  // ------------------ Internal Helpers ------------------ //

  bool _isSameSurahAndReciter(int surahNumber, String reciter) =>
      _lastLoadedSurah == surahNumber && _lastLoadedReciter == reciter;

  Future<void> _prepareAndEmitLoaded(
    int surahNumber,
    String reciter,
    int startAyah,
  ) async {
    await _repository.prepareSurahPlaylist(
      surahNumber: surahNumber,
      reciter: reciter,
    );

    _updateLastLoadedInfo(surahNumber, reciter);

    if (!isClosed) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.loaded,
          surahNumber: surahNumber,
          ayahCount: quran.getVerseCount(surahNumber),
          startAyah: startAyah,
        ),
      );
    }

    await _seekToAyahIfNeeded(startAyah);
  }

  Future<void> _seekToAyahIfNeeded(int startAyah) async {
    if (startAyah > 1) {
      await _repository.seek(Duration.zero, index: startAyah - 1);
    }
  }

  void _emitAlreadyLoaded(int surahNumber) {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.alreadyLoaded,
          surahNumber: state.surahNumber ?? surahNumber,
        ),
      );
    }
  }

  void _emitError(int surahNumber, Object error) {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: QuranSurahStatus.error,
          message: error.toString(),
          surahNumber: surahNumber,
        ),
      );
    }
  }

  void _updateLastLoadedInfo(int surahNumber, String reciter) {
    _lastLoadedSurah = surahNumber;
    _lastLoadedReciter = reciter;
  }
}
