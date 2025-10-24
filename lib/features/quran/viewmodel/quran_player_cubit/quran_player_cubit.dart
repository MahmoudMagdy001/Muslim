import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/quran_repository.dart';
import 'quran_player_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  QuranPlayerCubit(this._repository, {int? initialSurah})
    : super(QuranPlayerState(currentSurah: initialSurah)) {
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
      _repository.positionStream.listen(
        (position) => emit(state.copyWith(currentPosition: position)),
      ),
    );
  }

  void _listenToDuration() {
    _subscriptions.add(
      _repository.durationStream.listen((duration) {
        if (duration != null && duration.inMilliseconds > 0) {
          emit(state.copyWith(totalDuration: duration));
        }
      }),
    );
  }

  void _listenToPlayerState() {
    _subscriptions.add(
      _repository.playerStateStream.listen(
        (playerState) => emit(state.copyWith(isPlaying: playerState.playing)),
      ),
    );
  }

  void _listenToCurrentIndex() {
    _subscriptions.add(
      _repository.currentIndexStream.listen((index) {
        if (index != null) {
          final currentAyah = index + 1;
          emit(state.copyWith(currentAyah: currentAyah));
        }
      }),
    );
  }

  // -------------------- Player Controls -------------------- //

  Future<void> play() => _repository.play();

  Future<void> pause() => _repository.pause();

  Future<void> seek(Duration position, {int? index, int? surah}) async {
    await _repository.seek(position, index: index);
    if (surah != null) emit(state.copyWith(currentSurah: surah));
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
