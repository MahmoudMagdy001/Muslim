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
  AzkarAudioService(this._audioPlayer) {
    _init();
  }
  final AudioPlayer _audioPlayer;
  final StreamController<AzkarAudioState> _stateController =
      StreamController<AzkarAudioState>.broadcast();

  AzkarAudioState _state = const AzkarAudioState(
    status: AzkarAudioStatus.initial,
  );

  Stream<AzkarAudioState> get stateStream => _stateController.stream;
  AzkarAudioState get currentState => _state;

  void _init() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      final playing = playerState.playing;

      if (processingState == ProcessingState.completed ||
          processingState == ProcessingState.idle) {
        _updateState(status: AzkarAudioStatus.stopped);
      } else if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        // Only show loading if we are not explicitly stopped
        // (to avoid loading flash when stopping)
        if (_state.status != AzkarAudioStatus.stopped) {
          _updateState(status: AzkarAudioStatus.loading);
        }
      } else if (processingState == ProcessingState.ready) {
        if (playing) {
          _updateState(status: AzkarAudioStatus.playing);
        } else {
          // If we were playing and receive ready+!playing, it implies paused/stopped
          if (_state.status == AzkarAudioStatus.playing) {
            _updateState(status: AzkarAudioStatus.stopped);
          }
        }
      }
    });
  }

  void _updateState({AzkarAudioStatus? status, String? url}) {
    _state = _state.copyWith(status: status, url: url);
    if (!_stateController.isClosed) {
      _stateController.add(_state);
    }
  }

  Future<void> play(String url, {String? title}) async {
    try {
      final currentService = _getMetadataFromPlayer('service');
      final isOurService = currentService == 'azkar';

      if (isOurService &&
          _state.url == url &&
          _state.status == AzkarAudioStatus.playing) {
        await stop();
        return;
      }

      _updateState(status: AzkarAudioStatus.loading, url: url);

      // Enforce HTTPS
      final secureUrl = url.replaceAll('http://', 'https://');

      final source = AudioSource.uri(
        Uri.parse(secureUrl),
        tag: MediaItem(
          id: url,
          album: 'الأذكار',
          title: title ?? 'الذكر',
          extras: {'service': 'azkar'},
        ),
      );

      await _audioPlayer.setAudioSource(source);
      await _audioPlayer.play();
    } catch (e) {
      _updateState(status: AzkarAudioStatus.stopped);
      rethrow;
    }
  }

  dynamic _getMetadataFromPlayer(String key) {
    final tag = _audioPlayer.sequenceState.currentSource?.tag;
    if (tag is MediaItem) {
      return tag.extras?[key];
    }
    return null;
  }

  Future<void> stop() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
    _updateState(status: AzkarAudioStatus.stopped);
  }

  void dispose() {
    _stateController.close();
  }
}
