import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/quran_repository.dart';
import 'quran_player_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  QuranPlayerCubit(this._repository, {int? initialSurah})
    : super(
        QuranPlayerState(
          currentSurah: _repository.currentSurah ?? initialSurah,
          currentAyah: _repository.currentIndex != null
              ? _repository.currentIndex! + 1
              : null,
          isPlaying: _repository.isPlaying,
        ),
      ) {
    _initializeListeners();
  }

  final QuranRepository _repository;
  final List<StreamSubscription> _subscriptions = [];

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
      _repository.positionStream.listen((position) {
        if (!isClosed) emit(state.copyWith(currentPosition: position));
      }),
    );
  }

  void _listenToDuration() {
    _subscriptions.add(
      _repository.durationStream.listen((duration) {
        if (duration != null && duration.inMilliseconds > 0) {
          if (!isClosed) emit(state.copyWith(totalDuration: duration));
        }
      }),
    );
  }

  void _listenToPlayerState() {
    _subscriptions.add(
      _repository.playerStateStream.listen((playerState) {
        if (!isClosed) emit(state.copyWith(isPlaying: playerState.playing));
      }),
    );
  }

  void _listenToCurrentIndex() {
    _subscriptions.add(
      _repository.currentIndexStream.listen((index) {
        if (index != null) {
          final currentAyah = index + 1;
          if (!isClosed) emit(state.copyWith(currentAyah: currentAyah));
        }
      }),
    );
  }

  // -------------------- Player Controls -------------------- //

  Future<void> loadSurah(int surah, String reciter, {int startAyah = 1}) async {
    await _repository.prepareSurahPlaylist(
      surahNumber: surah,
      reciter: reciter,
    );

    final targetIndex = startAyah - 1;
    final isAlreadyAtTarget =
        _repository.currentSurah == surah &&
        _repository.currentIndex == targetIndex;

    if (startAyah > 1 && !isAlreadyAtTarget) {
      await _repository.seek(Duration.zero, index: targetIndex);
    }
    if (!isClosed) {
      emit(state.copyWith(currentSurah: surah, currentAyah: startAyah));
    }
  }

  Future<void> play() => _repository.play();

  Future<void> pause() => _repository.pause();

  Future<void> seek(Duration position, {int? index, int? surah}) async {
    await _repository.seek(position, index: index);
    if (surah != null && !isClosed) emit(state.copyWith(currentSurah: surah));
  }

  Future<void> seekToNext() => _repository.seekToNext();

  Future<void> seekToPrevious() => _repository.seekToPrevious();

  // -------------------- Cleanup -------------------- //

  @override
  Future<void> close() async {
    for (final sub in _subscriptions) {
      await sub.cancel();
    }
    return super.close();
  }
}
