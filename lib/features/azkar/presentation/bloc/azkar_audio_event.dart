import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:muslim/features/azkar/domain/entities/azkar_audio_state.dart';

part 'azkar_audio_event.freezed.dart';

@freezed
sealed class AzkarAudioEvent with _$AzkarAudioEvent {
  const factory AzkarAudioEvent.started() = AzkarAudioStarted;
  const factory AzkarAudioEvent.stateUpdated(AzkarAudioState state) = AzkarAudioStateUpdated;
  const factory AzkarAudioEvent.playRequested(String url, {String? title}) = AzkarAudioPlayRequested;
  const factory AzkarAudioEvent.stopRequested() = AzkarAudioStopRequested;
}
