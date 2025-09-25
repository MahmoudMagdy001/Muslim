import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart' as quran;

import '../../settings/consts/reciters_name_arabic.dart';

class QuranService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  int? _currentSurah;
  String? _currentReciter;

  int globalAyahNumber(int surah, int ayah) {
    int offset = 0;
    for (int s = 1; s < surah; s++) {
      offset += quran.getVerseCount(s);
    }
    return offset + ayah;
  }

  String ayahAudioUrl(String reciter, int verseNumber, {int bitrate = 64}) =>
      'https://cdn.islamic.network/quran/audio/$bitrate/$reciter/$verseNumber.mp3';

  Future<void> prepareSurahPlaylist({
    required int surahNumber,
    required String reciter,
  }) async {
    if (_currentSurah == surahNumber && _currentReciter == reciter) {
      return;
    }

    _currentSurah = surahNumber;
    _currentReciter = reciter;

    final ayahCount = quran.getVerseCount(surahNumber);

    final playlist = [
      for (int verseNumber = 1; verseNumber <= ayahCount; verseNumber++)
        AudioSource.uri(
          Uri.parse(
            ayahAudioUrl(reciter, globalAyahNumber(surahNumber, verseNumber)),
          ),
          tag: MediaItem(
            id: '${globalAyahNumber(surahNumber, verseNumber)}',
            album: 'سورة ${quran.getSurahNameArabic(surahNumber)}',
            title:
                'سورة ${quran.getSurahNameArabic(surahNumber)} - آية رقم : $verseNumber',
            artist: 'القارئ : ${getReciterName(reciter)}',
          ),
        ),
    ];

    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAudioSources(playlist);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> play() async => await _audioPlayer.play();
  Future<void> pause() async => await _audioPlayer.pause();
  Future<void> seek(Duration position, {int? index}) async =>
      await _audioPlayer.seek(position, index: index);
  Future<void> seekToNext() async => await _audioPlayer.seekToNext();
  Future<void> seekToPrevious() async => await _audioPlayer.seekToPrevious();

  void dispose() {
    _currentSurah = null;
    _currentReciter = null;
    _audioPlayer.dispose();
  }
}
