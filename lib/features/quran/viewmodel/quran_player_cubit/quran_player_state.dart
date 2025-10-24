class QuranPlayerState {
  const QuranPlayerState({
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.isPlaying = false,
    this.currentAyah,
    this.currentSurah,
  });

  final Duration currentPosition;
  final Duration totalDuration;
  final bool isPlaying;
  final int? currentAyah;
  final int? currentSurah;

  QuranPlayerState copyWith({
    Duration? currentPosition,
    Duration? totalDuration,
    bool? isPlaying,
    int? currentAyah,
    int? currentSurah,
  }) => QuranPlayerState(
    currentPosition: currentPosition ?? this.currentPosition,
    totalDuration: totalDuration ?? this.totalDuration,
    isPlaying: isPlaying ?? this.isPlaying,
    currentAyah: currentAyah ?? this.currentAyah,
    currentSurah: currentSurah ?? this.currentSurah,
  );
}
