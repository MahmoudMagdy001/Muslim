import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../domain/entities/azkar_audio_state.dart';
import 'azkar_audio_data_source.dart';

class AzkarAudioDataSourceImpl implements AzkarAudioDataSource {
  AzkarAudioDataSourceImpl(this._audioPlayer) {
    _init();
  }

  final AudioPlayer _audioPlayer;
  final StreamController<AzkarAudioState> _stateController =
      StreamController<AzkarAudioState>.broadcast();

  AzkarAudioState _state = const AzkarAudioState(
    status: AzkarAudioStatus.initial,
  );

  @override
  Stream<AzkarAudioState> get stateStream => _stateController.stream;

  @override
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
        if (_state.status != AzkarAudioStatus.stopped) {
          _updateState(status: AzkarAudioStatus.loading);
        }
      } else if (processingState == ProcessingState.ready) {
        if (playing) {
          _updateState(status: AzkarAudioStatus.playing);
        } else {
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

  @override
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
          extras: const {'service': 'azkar'},
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

  @override
  Future<void> stop() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
    _updateState(status: AzkarAudioStatus.stopped);
  }

  @override
  void dispose() {
    _stateController.close();
  }
}
