import 'package:just_audio/just_audio.dart';

abstract class QuranRepository {
  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;
  Stream<PlayerState> get playerStateStream;
  Stream<int?> get currentIndexStream;
  int? get currentIndex;
  bool get isPlaying;
  int? get currentSurah;

  Future<void> prepareSurahPlaylist({
    required int surahNumber,
    required String reciter,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration position, {int? index});
  Future<void> seekToNext();
  Future<void> seekToPrevious();

  Future<Duration?> getCurrentDuration();
  void dispose();
}
