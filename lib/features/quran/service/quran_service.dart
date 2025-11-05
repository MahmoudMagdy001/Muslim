import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/consts/reciters_name_arabic.dart';

class QuranService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // StreamController لتحديثات آخر آية تم الاستماع إليها
  final StreamController<Map<String, dynamic>?> _lastPlayedController =
      StreamController<Map<String, dynamic>?>.broadcast();

  AudioPlayer get audioPlayer => _audioPlayer;

  int? _currentSurah;
  String? _currentReciter;

  /// يحسب الرقم التسلسلي العام للآية (عبر جميع السور)
  int globalAyahNumber(int surah, int ayah) {
    int offset = 0;
    for (int s = 1; s < surah; s++) {
      offset += quran.getVerseCount(s);
    }
    return offset + ayah;
  }

  /// يبني رابط الصوت لآية معينة
  String ayahAudioUrl(String reciter, int verseNumber, {int bitrate = 64}) =>
      'https://cdn.islamic.network/quran/audio/$bitrate/$reciter/$verseNumber.mp3';

  /// تحضير قائمة تشغيل للسورة المختارة
  StreamSubscription<int?>? _indexSubscription;

  Future<void> prepareSurahPlaylist({
    required int surahNumber,
    required String reciter,
  }) async {
    if (_isSameAsCurrent(surahNumber, reciter)) return;

    _currentSurah = surahNumber;
    _currentReciter = reciter;

    final playlist = _buildPlaylist(surahNumber, reciter);

    await _audioPlayer.stop();
    await _audioPlayer.setAudioSources(playlist);

    _indexSubscription?.cancel(); // إلغاء القديم
    _indexSubscription = _audioPlayer.currentIndexStream.listen((index) async {
      if (index != null) {
        print('Index changed: $index'); // 🔹

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('lastSurah', surahNumber);
        await prefs.setInt('lastVerse', index + 1);
        await prefs.setString('lastReciter', reciter);

        // إرسال البيانات عبر الـ Stream
        _lastPlayedController.add({
          'surah': surahNumber,
          'verse': index + 1,
          'reciter': reciter,
        });
        print('LastPlayed emitted: ${index + 1}'); // 🔹
      }
    });
  }

  /// تشغيل الصوت
  Future<void> play() => _audioPlayer.play();

  /// إيقاف مؤقت
  Future<void> pause() => _audioPlayer.pause();

  /// الانتقال إلى موضع أو آية معينة
  Future<void> seek(Duration position, {int? index}) =>
      _audioPlayer.seek(position, index: index);

  /// الانتقال إلى الآية التالية
  Future<void> seekToNext() => _audioPlayer.seekToNext();

  /// الانتقال إلى الآية السابقة
  Future<void> seekToPrevious() => _audioPlayer.seekToPrevious();

  /// الحصول على Stream لتحديثات آخر استماع
  Stream<Map<String, dynamic>?> get lastPlayedStream =>
      _lastPlayedController.stream;

  /// تنظيف الموارد
  void dispose() {
    _audioPlayer.stop();
    _indexSubscription?.cancel();
    _currentSurah = null;
    _currentReciter = null;
    _audioPlayer.dispose();
    _lastPlayedController.close(); // إغلاق الـ StreamController
  }

  // ------------------ Internal Helpers ------------------ //

  bool _isSameAsCurrent(int surah, String reciter) =>
      _currentSurah == surah && _currentReciter == reciter;

  /// يبني قائمة التشغيل لكل آيات السورة
  List<AudioSource> _buildPlaylist(int surahNumber, String reciter) {
    final ayahCount = quran.getVerseCount(surahNumber);
    return List.generate(
      ayahCount,
      (index) => _createAudioSourceForVerse(
        surahNumber: surahNumber,
        verseNumber: index + 1,
        reciter: reciter,
      ),
    );
  }

  /// يبني مصدر الصوت لكل آية مع بياناتها
  AudioSource _createAudioSourceForVerse({
    required int surahNumber,
    required int verseNumber,
    required String reciter,
  }) {
    final verseId = globalAyahNumber(surahNumber, verseNumber);
    final surahName = quran.getSurahNameArabic(surahNumber);

    return AudioSource.uri(
      Uri.parse(ayahAudioUrl(reciter, verseId)),
      tag: MediaItem(
        id: '$verseId',
        album: 'سورة $surahName',
        title: 'سورة $surahName - آية رقم: $verseNumber',
        artist: 'القارئ: ${getReciterName(reciter)}',
      ),
    );
  }

  Future<Map<String, dynamic>?> getLastPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final surah = prefs.getInt('lastSurah');
    final verse = prefs.getInt('lastVerse');
    final reciter = prefs.getString('lastReciter');
    if (surah == null || verse == null || reciter == null) return null;

    return {'surah': surah, 'verse': verse, 'reciter': reciter};
  }
}
