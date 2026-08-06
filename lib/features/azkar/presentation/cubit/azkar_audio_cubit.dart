import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';

class AzkarAudioCubit extends Cubit<AzkarAudioState> {
  AzkarAudioCubit(this._repository) : super(const AzkarAudioState(status: AzkarAudioStatus.initial)) {
    _init();
  }

  final AzkarRepository _repository;

  StreamSubscription<AzkarAudioState>? _subscription;

  void _init() {
    emit(_repository.currentAudioState);
    _subscription = _repository.getAudioStateStream().listen((state) {
      if (!isClosed) {
        emit(state);
      }
    });
  }

  Future<void> playAudio(String url, {String? title}) async {
    await _repository.playAudio(url, title: title);
  }

  Future<void> stopAudio() async {
    await _repository.stopAudio();
  }

  @override
  Future<void> close() {
    unawaited(_subscription?.cancel());
    return super.close();
  }
}
