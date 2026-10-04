import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_player_state.freezed.dart';

@freezed
abstract class QuranPlayerState with _$QuranPlayerState {
  const factory QuranPlayerState({
    @Default(Duration.zero) Duration currentPosition,
    @Default(Duration.zero) Duration totalDuration,
    @Default(false) bool isPlaying,
    int? currentAyah,
    int? currentSurah,
  }) = _QuranPlayerState;
}
