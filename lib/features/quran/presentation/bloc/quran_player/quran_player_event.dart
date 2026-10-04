import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_player_event.freezed.dart';

@freezed
sealed class QuranPlayerEvent with _$QuranPlayerEvent {
  const factory QuranPlayerEvent.loadSurah({
    required int surah,
    required String reciter,
    @Default(1) int startAyah,
  }) = QuranPlayerLoadSurah;

  const factory QuranPlayerEvent.loadRange({
    required int fromPage,
    required int toPage,
    required String reciter,
    required int startSurah,
    required int startAyah,
  }) = QuranPlayerLoadRange;

  const factory QuranPlayerEvent.play() = QuranPlayerPlay;
  const factory QuranPlayerEvent.pause() = QuranPlayerPause;
  const factory QuranPlayerEvent.seek({
    required Duration position,
    int? index,
    int? surah,
  }) = QuranPlayerSeek;

  const factory QuranPlayerEvent.seekToAyah({
    required int surah,
    required int ayah,
  }) = QuranPlayerSeekToAyah;

  const factory QuranPlayerEvent.seekToNext() = QuranPlayerSeekToNext;
  const factory QuranPlayerEvent.seekToPrevious() = QuranPlayerSeekToPrevious;

  const factory QuranPlayerEvent.positionChanged(Duration position) = QuranPlayerPositionChanged;
  const factory QuranPlayerEvent.durationChanged(Duration duration) = QuranPlayerDurationChanged;
  const factory QuranPlayerEvent.playerStateChanged({required bool isPlaying}) = QuranPlayerPlayerStateChanged;
  const factory QuranPlayerEvent.currentIndexChanged(int index) = QuranPlayerCurrentIndexChanged;
}
