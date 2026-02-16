import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/consts/reciters_name_arabic.dart';

class QuranService {
  QuranService(this._audioPlayer);
  final AudioPlayer _audioPlayer;

  // StreamController لتحديثات آخر آية تم الاستماع إليها
  final StreamController<Map<String, dynamic>?> _lastPlayedController =
      StreamController<Map<String, dynamic>?>.broadcast();

  // StreamController لنقرات الإشعارات
  final StreamController<bool> _notificationClickController =
      StreamController<bool>.broadcast();

  bool _pendingNotificationClick = false;
  bool get hasPendingNotificationClick => _pendingNotificationClick;

  AudioPlayer get audioPlayer => _audioPlayer;

  int? get currentSurah => _currentSurah ?? _getMetadataFromPlayer('surah');
  String? get currentReciter =>
      _currentReciter ?? _getMetadataFromPlayer('reciter');

  int? _currentSurah;
  String? _currentReciter;

  /// Maps playlist index → (surah, ayah) for range-based playlists
  List<({int surah, int ayah})> _rangeAyahMap = [];

  /// Returns the (surah, ayah) at a given playlist index, if a range playlist is active
  ({int surah, int ayah})? getAyahAtIndex(int index) {
    if (index >= 0 && index < _rangeAyahMap.length) {
      return _rangeAyahMap[index];
    }
    return null;
  }

  dynamic _getMetadataFromPlayer(String key) {
    final tag = _audioPlayer.sequenceState.currentSource?.tag;
    if (tag is MediaItem) {
      return tag.extras?[key];
    }
    return null;
  }

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
    if (_isSameAsCurrent(surahNumber, reciter) &&
        _audioPlayer.audioSource != null) {
      return;
    }

    _currentSurah = surahNumber;
    _currentReciter = reciter;
    _rangeAyahMap = []; // Clear range map for single-surah mode

    final playlist = _buildPlaylist(surahNumber, reciter);

    await _audioPlayer.stop();
    await _audioPlayer.setAudioSources(playlist);

    _indexSubscription?.cancel();
    _indexSubscription = _audioPlayer.currentIndexStream.listen((index) async {
      if (index != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('lastSurah', surahNumber);
        await prefs.setInt('lastVerse', index + 1);
        await prefs.setString('lastReciter', reciter);

        _lastPlayedController.add({
          'surah': surahNumber,
          'verse': index + 1,
          'reciter': reciter,
        });
      }
    });
  }

  /// تحضير قائمة تشغيل لنطاق صفحات (للأحزاب والأجزاء)
  Future<void> prepareRangePlaylist({
    required int fromPage,
    required int toPage,
    required String reciter,
  }) async {
    _currentReciter = reciter;

    // Build the ayah map and playlist from page range
    final ayahMap = <({int surah, int ayah})>[];
    final audioSources = <AudioSource>[];
    final seen = <String>{}; // Avoid duplicates across page boundaries

    for (int page = fromPage; page <= toPage; page++) {
      final pageData = quran.getPageData(page);
      for (final data in pageData) {
        final rowData = data as Map<String, dynamic>;
        final surah = rowData['surah'] as int;
        final start = rowData['start'] as int;
        final end = rowData['end'] as int;

        for (int ayah = start; ayah <= end; ayah++) {
          final key = '${surah}_$ayah';
          if (seen.contains(key)) continue;
          seen.add(key);

          ayahMap.add((surah: surah, ayah: ayah));
          audioSources.add(
            _createAudioSourceForVerse(
              surahNumber: surah,
              verseNumber: ayah,
              reciter: reciter,
            ),
          );
        }
      }
    }

    _rangeAyahMap = ayahMap;
    if (ayahMap.isNotEmpty) {
      _currentSurah = ayahMap.first.surah;
    }

    await _audioPlayer.stop();
    await _audioPlayer.setAudioSources(audioSources);

    _indexSubscription?.cancel();
    _indexSubscription = _audioPlayer.currentIndexStream.listen((index) async {
      if (index != null && index < _rangeAyahMap.length) {
        final entry = _rangeAyahMap[index];
        _currentSurah = entry.surah;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('lastSurah', entry.surah);
        await prefs.setInt('lastVerse', entry.ayah);
        await prefs.setString('lastReciter', reciter);

        _lastPlayedController.add({
          'surah': entry.surah,
          'verse': entry.ayah,
          'reciter': reciter,
        });
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

  /// الحصول على Stream لنقرات الإشعارات
  Stream<bool> get notificationClickStream =>
      _notificationClickController.stream;

  /// إرسال حدث نقرة الإشعار
  void onNotificationClick() {
    if (_notificationClickController.hasListener) {
      _notificationClickController.add(true);
    } else {
      _pendingNotificationClick = true;
    }
  }

  /// استهلاك النقرة المنتظرة
  void consumePendingNotificationClick() {
    _pendingNotificationClick = false;
  }

  /// تنظيف الموارد
  void dispose() {
    _audioPlayer.stop();
    _indexSubscription?.cancel();
    _currentSurah = null;
    _currentReciter = null;
    _lastPlayedController.close(); // إغلاق الـ StreamController
  }

  // ------------------ Internal Helpers ------------------ //

  bool _isSameAsCurrent(int surah, String reciter) {
    final hasQuranMetadata = _getMetadataFromPlayer('surah') != null;
    return _currentSurah == surah &&
        _currentReciter == reciter &&
        hasQuranMetadata;
  }

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
        extras: {'surah': surahNumber, 'reciter': reciter},
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
