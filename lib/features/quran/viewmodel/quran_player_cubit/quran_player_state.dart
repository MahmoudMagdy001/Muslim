class QuranPlayerState {
  const QuranPlayerState({
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.isPlaying = false,
    this.currentAyah = 1,
  });

  final Duration currentPosition;
  final Duration totalDuration;
  final bool isPlaying;
  final int currentAyah;

  QuranPlayerState copyWith({
    Duration? currentPosition,
    Duration? totalDuration,
    bool? isPlaying,
    int? currentAyah,
  }) => QuranPlayerState(
    currentPosition: currentPosition ?? this.currentPosition,
    totalDuration: totalDuration ?? this.totalDuration,
    isPlaying: isPlaying ?? this.isPlaying,
    currentAyah: currentAyah ?? this.currentAyah,
  );
}
