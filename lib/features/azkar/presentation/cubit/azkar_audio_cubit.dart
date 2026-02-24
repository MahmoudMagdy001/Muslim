import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/azkar_audio_state.dart';
import '../../domain/usecases/get_azkar_audio_stream_usecase.dart';
import '../../domain/usecases/get_current_audio_state_usecase.dart';
import '../../domain/usecases/play_azkar_audio_usecase.dart';
import '../../domain/usecases/stop_azkar_audio_usecase.dart';

class AzkarAudioCubit extends Cubit<AzkarAudioState> {
  AzkarAudioCubit(
    this._playAzkarAudioUseCase,
    this._stopAzkarAudioUseCase,
    this._getAzkarAudioStreamUseCase,
    this._getCurrentAudioStateUseCase,
  ) : super(const AzkarAudioState(status: AzkarAudioStatus.initial)) {
    _init();
  }

  final PlayAzkarAudioUseCase _playAzkarAudioUseCase;
  final StopAzkarAudioUseCase _stopAzkarAudioUseCase;
  final GetAzkarAudioStreamUseCase _getAzkarAudioStreamUseCase;
  final GetCurrentAudioStateUseCase _getCurrentAudioStateUseCase;

  StreamSubscription<AzkarAudioState>? _subscription;

  void _init() {
    emit(_getCurrentAudioStateUseCase());
    _subscription = _getAzkarAudioStreamUseCase().listen((state) {
      if (!isClosed) {
        emit(state);
      }
    });
  }

  Future<void> playAudio(String url, {String? title}) async {
    await _playAzkarAudioUseCase(PlayAzkarAudioParams(url: url, title: title));
  }

  Future<void> stopAudio() async {
    await _stopAzkarAudioUseCase(NoParams());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
