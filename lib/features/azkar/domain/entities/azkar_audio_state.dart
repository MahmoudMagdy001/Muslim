import 'package:freezed_annotation/freezed_annotation.dart';

part 'azkar_audio_state.freezed.dart';

enum AzkarAudioStatus { initial, loading, playing, stopped }

@freezed
abstract class AzkarAudioState with _$AzkarAudioState {
  const factory AzkarAudioState({
    required AzkarAudioStatus status,
    String? url,
  }) = _AzkarAudioState;
}
