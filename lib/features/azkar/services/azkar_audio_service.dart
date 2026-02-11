import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

enum AzkarAudioStatus { initial, loading, playing, stopped }

class AzkarAudioState {
  const AzkarAudioState({required this.status, this.url});

  final AzkarAudioStatus status;
  final String? url;

  AzkarAudioState copyWith({AzkarAudioStatus? status, String? url}) =>
      AzkarAudioState(status: status ?? this.status, url: url ?? this.url);
}

class AzkarAudioService {
  AzkarAudioService() {
    _init();
  }
  final AudioPlayer _audioPlayer = AudioPlayer();
  final StreamController<AzkarAudioState> _stateController =
      StreamController<AzkarAudioState>.broadcast();

  AzkarAudioState _state = const AzkarAudioState(
    status: AzkarAudioStatus.initial,
  );

  Stream<AzkarAudioState> get stateStream => _stateController.stream;
  AzkarAudioState get currentState => _state;

  void _init() {
    _audioPlayer.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        _updateState(status: AzkarAudioStatus.stopped);
      } else if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        _updateState(status: AzkarAudioStatus.loading);
      } else if (processingState == ProcessingState.ready &&
          _audioPlayer.playing) {
        _updateState(status: AzkarAudioStatus.playing);
      }
    });

    _audioPlayer.playingStream.listen((playing) {
      if (playing) {
        _updateState(status: AzkarAudioStatus.playing);
      } else if (_state.status == AzkarAudioStatus.playing) {
        _updateState(status: AzkarAudioStatus.stopped);
      }
    });
  }

  void _updateState({AzkarAudioStatus? status, String? url}) {
    _state = _state.copyWith(status: status, url: url);
    _stateController.add(_state);
  }

  Future<void> play(String url, {String? title}) async {
    try {
      if (_state.url == url && _state.status == AzkarAudioStatus.playing) {
        await stop();
        return;
      }

      _updateState(status: AzkarAudioStatus.loading, url: url);

      // Enforce HTTPS
      final secureUrl = url.replaceAll('http://', 'https://');

      final source = AudioSource.uri(
        Uri.parse(secureUrl),
        tag: MediaItem(id: url, album: 'الأذكار', title: title ?? 'الذكر'),
      );

      await _audioPlayer.setAudioSource(source);
      await _audioPlayer.play();
    } catch (e) {
      _updateState(status: AzkarAudioStatus.stopped);
      rethrow;
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _updateState(status: AzkarAudioStatus.stopped);
  }

  void dispose() {
    _audioPlayer.dispose();
    _stateController.close();
  }
}
