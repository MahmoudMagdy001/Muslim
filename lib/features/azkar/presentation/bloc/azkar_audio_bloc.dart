import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';
import 'package:muslim/features/azkar/domain/repositories/azkar_repository.dart';
import 'package:muslim/features/azkar/presentation/bloc/azkar_audio_event.dart';

export 'azkar_audio_event.dart';

class AzkarAudioBloc extends Bloc<AzkarAudioEvent, AzkarAudioState> {
  AzkarAudioBloc(this._repository)
    : super(const AzkarAudioState(status: AzkarAudioStatus.initial)) {
    on<AzkarAudioStarted>(_onStarted);
    on<AzkarAudioStateUpdated>(_onStateUpdated);
    on<AzkarAudioPlayRequested>(_onPlayRequested);
    on<AzkarAudioStopRequested>(_onStopRequested);

    add(const AzkarAudioEvent.started());
  }

  final AzkarRepository _repository;
  StreamSubscription<AzkarAudioState>? _subscription;

  void _onStarted(
    AzkarAudioStarted event,
    Emitter<AzkarAudioState> emit,
  ) {
    emit(_repository.currentAudioState);
    unawaited(_subscription?.cancel());
    _subscription = _repository.getAudioStateStream().listen((audioState) {
      add(AzkarAudioEvent.stateUpdated(audioState));
    });
  }

  void _onStateUpdated(
    AzkarAudioStateUpdated event,
    Emitter<AzkarAudioState> emit,
  ) {
    emit(event.state);
  }

  Future<void> _onPlayRequested(
    AzkarAudioPlayRequested event,
    Emitter<AzkarAudioState> emit,
  ) async {
    await _repository.playAudio(event.url, title: event.title);
  }

  Future<void> _onStopRequested(
    AzkarAudioStopRequested event,
    Emitter<AzkarAudioState> emit,
  ) async {
    await _repository.stopAudio();
  }

  // Convenience methods
  Future<void> playAudio(String url, {String? title}) async =>
      add(AzkarAudioEvent.playRequested(url, title: title));

  Future<void> stopAudio() async => add(const AzkarAudioEvent.stopRequested());

  @override
  Future<void> close() {
    unawaited(_subscription?.cancel());
    return super.close();
  }
}

typedef AzkarAudioCubit = AzkarAudioBloc;
