import 'package:just_audio/just_audio.dart';
import 'quran_repository.dart';
import '../service/quran_service.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranService _quranService = QuranService();
  // final LastReadService _lastReadService = LastReadService();

  @override
  Stream<Duration> get positionStream =>
      _quranService.audioPlayer.positionStream;

  @override
  Stream<Duration?> get durationStream =>
      _quranService.audioPlayer.durationStream;

  @override
  Stream<PlayerState> get playerStateStream =>
      _quranService.audioPlayer.playerStateStream;

  @override
  Stream<int?> get currentIndexStream =>
      _quranService.audioPlayer.currentIndexStream;

  @override
  Future<void> prepareSurahPlaylist({
    required int surahNumber,
    required String reciter,
  }) async => await _quranService.prepareSurahPlaylist(
    surahNumber: surahNumber,
    reciter: reciter,
  );

  @override
  Future<void> play() async => await _quranService.play();

  @override
  Future<void> pause() async => await _quranService.pause();

  @override
  Future<void> seek(Duration position, {int? index}) async =>
      await _quranService.seek(position, index: index);

  @override
  Future<void> seekToNext() async => await _quranService.seekToNext();

  @override
  Future<void> seekToPrevious() async => await _quranService.seekToPrevious();

  @override
  void dispose() {
    _quranService.dispose();
  }

  @override
  Future<Duration?> getCurrentDuration() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      return _quranService.audioPlayer.duration;
    } catch (e) {
      return null;
    }
  }
}
