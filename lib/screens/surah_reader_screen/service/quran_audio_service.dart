// import 'package:flutter/material.dart';

// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:quran/quran.dart' as quran;

// import '../../../core/consts/reciters_name_arabic.dart';
// import '../../../core/service/last_read_service.dart';

// class QuranAudioService extends ChangeNotifier {
//   QuranAudioService() {
//     _listenToPlayerState();
//     _loadLastRead();
//   }

//   static final AudioPlayer instance = AudioPlayer();
//   final LastReadService _lastReadService = LastReadService();

//   int? _currentAyah;
//   int? _currentSurah;

//   int? get currentAyah => _currentAyah;
//   int? get currentSurah => _currentSurah;
//   AudioPlayer get player => instance;

//   void _listenToPlayerState() {
//     instance.currentIndexStream.listen((index) async {
//       if (index != null && _currentSurah != null) {
//         _currentAyah = index + 1;

//         await _lastReadService.saveLastRead(
//           surah: _currentSurah!,
//           ayah: _currentAyah!,
//         );

//         notifyListeners();
//       }
//     });
//   }

//   Future<void> _loadLastRead() async {
//     final data = await _lastReadService.loadLastRead();
//     _currentSurah = data['surah'];
//     _currentAyah = data['ayah'];
//     notifyListeners();
//   }

//   Future<Map<String, dynamic>> loadLastRead() async =>
//       await _lastReadService.loadLastRead();

//   int _globalAyahNumber(int surah, int ayah) {
//     int offset = 0;
//     for (int s = 1; s < surah; s++) {
//       offset += quran.getVerseCount(s);
//     }
//     return offset + ayah;
//   }

//   String _ayahAudioUrl(String reciter, int verseNumber, {int bitreate = 64}) =>
//       'https://cdn.islamic.network/quran/audio/$bitreate/$reciter/$verseNumber.mp3';

//   Future<void> prepareSurahPlaylist({
//     required int surahNumber,
//     required String reciter,
//   }) async {
//     final ayahCount = quran.getVerseCount(surahNumber);
//     _currentSurah = surahNumber;

//     final playlist = [
//       for (int verseNumber = 1; verseNumber <= ayahCount; verseNumber++)
//         AudioSource.uri(
//           Uri.parse(
//             _ayahAudioUrl(reciter, _globalAyahNumber(surahNumber, verseNumber)),
//           ),
//           tag: MediaItem(
//             id: '${_globalAyahNumber(surahNumber, verseNumber)}',
//             album: 'سورة ${quran.getSurahNameArabic(surahNumber)}',
//             title:
//                 'سورة ${quran.getSurahNameArabic(surahNumber)} - آية رقم : $verseNumber',
//             artist: 'القارئ : ${getReciterName(reciter)}',
//           ),
//         ),
//     ];

//     try {
//       await instance.stop();
//       await instance.setAudioSources(playlist);
//     } catch (e) {
//       debugPrint('Error loading audios: $e');
//       rethrow;
//     }
//   }

//   Future<void> resumeLastRead(String reciter) async {
//     if (_currentSurah == null || _currentAyah == null) return;

//     await prepareSurahPlaylist(surahNumber: _currentSurah!, reciter: reciter);
//     await instance.seek(Duration.zero, index: _currentAyah! - 1);
//     await play();
//   }

//   Future<void> play() async => await instance.play();
//   Future<void> pause() async => await instance.pause();
//   Future<void> seek(Duration position, {int? index}) async =>
//       await instance.seek(position, index: index);
//   Future<void> seekToNext() async => await instance.seekToNext();
//   Future<void> seekToPrevious() async => await instance.seekToPrevious();

//   @override
//   void dispose() {
//     instance.dispose();
//     super.dispose();
//   }
// }
