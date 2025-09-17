import 'package:just_audio/just_audio.dart';

abstract class QuranRepository {
  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;
  Stream<PlayerState> get playerStateStream;
  Stream<int?> get currentIndexStream;

  Future<void> prepareSurahPlaylist({
    required int surahNumber,
    required String reciter,
  });
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration position, {int? index});
  Future<void> seekToNext();
  Future<void> seekToPrevious();
  Future<Map<String, dynamic>> loadLastRead();
  Future<void> saveLastRead({required int surah, required int ayah});
  Future<Duration?> getCurrentDuration();
  void dispose();
}
