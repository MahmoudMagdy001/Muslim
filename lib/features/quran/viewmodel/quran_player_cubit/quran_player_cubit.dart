import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/quran_repository.dart';
import 'quran_player_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  QuranPlayerCubit(this._repository) : super(const QuranPlayerState()) {
    _initializePlayerListeners();
  }

  final QuranRepository _repository;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _currentIndexSubscription;

  void _initializePlayerListeners() {
    _setupPositionListener();
    _setupDurationListener();
    _setupPlayerStateListener();
    _setupCurrentIndexListener();
  }

  void _setupPositionListener() {
    _positionSubscription = _repository.positionStream.listen((position) {
      emit(state.copyWith(currentPosition: position));
    });
  }

  void _setupDurationListener() {
    _durationSubscription = _repository.durationStream.listen((duration) {
      if (duration != null && duration.inMilliseconds > 0) {
        emit(state.copyWith(totalDuration: duration));
      }
    });
  }

  void _setupPlayerStateListener() {
    _playerStateSubscription = _repository.playerStateStream.listen((
      playerState,
    ) {
      emit(state.copyWith(isPlaying: playerState.playing));
    });
  }

  void _setupCurrentIndexListener() {
    _currentIndexSubscription = _repository.currentIndexStream.listen((index) {
      if (index != null) {
        emit(state.copyWith(currentAyah: index + 1));
      }
    });
  }

  // Player Controls
  Future<void> play() async => await _repository.play();
  Future<void> pause() async => await _repository.pause();
  Future<void> seek(Duration position, {int? index}) async =>
      await _repository.seek(position, index: index);
  Future<void> seekToNext() async => await _repository.seekToNext();
  Future<void> seekToPrevious() async => await _repository.seekToPrevious();

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _currentIndexSubscription?.cancel();
    return super.close();
  }
}
