import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/quran/viewmodel/quran_player_cubit/quran_player_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  QuranPlayerCubit(this._quranService, {int? initialSurah})
    : super(
        QuranPlayerState(
          currentSurah: _quranService.currentSurah ?? initialSurah,
          currentAyah: _quranService.audioPlayer.currentIndex != null
              ? _quranService.audioPlayer.currentIndex! + 1
              : null,
          isPlaying: _quranService.audioPlayer.playing,
        ),
      ) {
    _initializeListeners();
  }

  final QuranService _quranService;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _isRangeMode = false;

  // -------------------- Initialization -------------------- //

  void _initializeListeners() {
    _listenToPosition();
    _listenToDuration();
    _listenToPlayerState();
    _listenToCurrentIndex();
  }

  // -------------------- Stream Listeners -------------------- //

  void _listenToPosition() {
    _subscriptions.add(
      _quranService.audioPlayer.positionStream.listen((position) {
        if (!isClosed) emit(state.copyWith(currentPosition: position));
      }),
    );
  }

  void _listenToDuration() {
    _subscriptions.add(
      _quranService.audioPlayer.durationStream.listen((duration) {
        if (duration != null && duration.inMilliseconds > 0) {
          if (!isClosed) emit(state.copyWith(totalDuration: duration));
        }
      }),
    );
  }

  void _listenToPlayerState() {
    _subscriptions.add(
      _quranService.audioPlayer.playerStateStream.listen((playerState) {
        if (!isClosed) emit(state.copyWith(isPlaying: playerState.playing));
      }),
    );
  }

  void _listenToCurrentIndex() {
    _subscriptions.add(
      _quranService.audioPlayer.currentIndexStream.listen((index) {
        if (index != null) {
          if (_isRangeMode) {
            // In range mode, resolve the actual surah/ayah from the map
            final entry = _quranService.getAyahAtIndex(index);
            if (entry != null && !isClosed) {
              emit(
                state.copyWith(
                  currentSurah: entry.surah,
                  currentAyah: entry.ayah,
                ),
              );
            }
          } else {
            final currentAyah = index + 1;
            if (!isClosed) emit(state.copyWith(currentAyah: currentAyah));
          }
        }
      }),
    );
  }

  // -------------------- Player Controls -------------------- //

  Future<void> loadSurah(int surah, String reciter, {int startAyah = 1}) async {
    _isRangeMode = false;
    await _quranService.prepareSurahPlaylist(
      surahNumber: surah,
      reciter: reciter,
    );

    final targetIndex = startAyah - 1;
    final isAlreadyAtTarget =
        _quranService.currentSurah == surah &&
        _quranService.audioPlayer.currentIndex == targetIndex;

    if (startAyah > 1 && !isAlreadyAtTarget) {
      await _quranService.seek(Duration.zero, index: targetIndex);
    }
    if (!isClosed) {
      emit(state.copyWith(currentSurah: surah, currentAyah: startAyah));
    }
  }

  Future<void> loadRange({
    required int fromPage,
    required int toPage,
    required String reciter,
    required int startSurah,
    required int startAyah,
  }) async {
    _isRangeMode = true;
    await _quranService.prepareRangePlaylist(
      fromPage: fromPage,
      toPage: toPage,
      reciter: reciter,
    );

    // Find the index in the range playlist that matches the start surah/ayah
    var targetIndex = 0;
    for (var i = 0; ; i++) {
      final entry = _quranService.getAyahAtIndex(i);
      if (entry == null) break;
      if (entry.surah == startSurah && entry.ayah == startAyah) {
        targetIndex = i;
        break;
      }
    }

    if (targetIndex > 0) {
      await _quranService.seek(Duration.zero, index: targetIndex);
    }

    if (!isClosed) {
      emit(state.copyWith(currentSurah: startSurah, currentAyah: startAyah));
    }
  }

  Future<void> play() => _quranService.play();

  Future<void> pause() => _quranService.pause();

  Future<void> seek(Duration position, {int? index, int? surah}) async {
    await _quranService.seek(position, index: index);
    if (surah != null && !isClosed) emit(state.copyWith(currentSurah: surah));
  }

  /// Seeks to a specific surah and ayah, resolving the correct playlist index
  /// in both range mode and single-surah mode.
  Future<void> seekToAyah(int surah, int ayah) async {
    if (_isRangeMode) {
      // Find the index in the range playlist that matches the surah/ayah
      for (var i = 0; ; i++) {
        final entry = _quranService.getAyahAtIndex(i);
        if (entry == null) break;
        if (entry.surah == surah && entry.ayah == ayah) {
          await _quranService.seek(Duration.zero, index: i);
          if (!isClosed) {
            emit(state.copyWith(currentSurah: surah, currentAyah: ayah));
          }
          return;
        }
      }
    } else {
      // Single surah mode: index is ayah - 1
      await _quranService.seek(Duration.zero, index: ayah - 1);
      if (!isClosed) {
        emit(state.copyWith(currentSurah: surah, currentAyah: ayah));
      }
    }
  }

  Future<void> seekToNext() => _quranService.seekToNext();

  Future<void> seekToPrevious() => _quranService.seekToPrevious();

  // -------------------- Cleanup -------------------- //

  @override
  Future<void> close() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    return super.close();
  }
}
