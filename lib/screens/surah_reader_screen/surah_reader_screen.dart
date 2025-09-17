// // ignore_for_file: avoid_dynamic_calls

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import '../../core/consts/reciters_name_arabic.dart';
// import '../../core/service/last_read_service.dart';
// import 'service/quran_audio_service.dart';
// import '../../features/quran/view/widgets/player_controls_widget.dart';
// import '../../features/quran/view/widgets/surah_text_view.dart';
// import 'package:provider/provider.dart';
// import 'package:quran/quran.dart' as quran;

// class SurahReaderScreen extends StatefulWidget {
//   const SurahReaderScreen({
//     required this.surahNumber,
//     required this.reciter,
//     super.key,
//   });

//   final int surahNumber;
//   final String reciter;

//   @override
//   State<SurahReaderScreen> createState() => _SurahReaderScreenState();
// }

// class _SurahReaderScreenState extends State<SurahReaderScreen> {
//   late QuranAudioService _audioService;
//   late LastReadService _lastReadService;

//   String? _cachedReciterName;

//   bool _isInitializing = false;
//   bool _isDisposed = false;

//   Timer? _ayahChangeDebouncer;
//   int? _lastSavedAyah;

//   @override
//   void initState() {
//     super.initState();
//     _initializeServices();
//     _scheduleInitialization();
//   }

//   void _initializeServices() {
//     _audioService = Provider.of<QuranAudioService>(context, listen: false);
//     _lastReadService = LastReadService();
//     _audioService.addListener(_onAyahChangedDebounced);
//   }

//   void _scheduleInitialization() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!_isDisposed && mounted) {
//         _initializeAndLoad();
//       }
//     });
//   }

//   String _getReciterName() {
//     // Cache the reciter name to avoid repeated lookups
//     _cachedReciterName ??= getReciterName(widget.reciter);
//     return _cachedReciterName!;
//   }

//   Future<void> _initializeAndLoad() async {
//     if (_isDisposed || !mounted || _isInitializing) return;

//     _isInitializing = true;

//     try {
//       // Check if same surah and reciter are already loaded
//       if (await _isSameSurahAndReciterLoaded()) {
//         await _handleSameSurahLoaded();
//         return;
//       }

//       // Load new surah
//       await _loadNewSurah();
//     } catch (e) {
//       debugPrint('Error in initialization: $e');
//     } finally {
//       if (mounted) {
//         _isInitializing = false;
//       }
//     }
//   }

//   Future<bool> _isSameSurahAndReciterLoaded() async {
//     if (_audioService.player.sequence.isEmpty) return false;

//     final currentTag = _audioService.player.sequence.first.tag as MediaItem?;
//     if (currentTag == null) return false;

//     final expectedAlbum =
//         'سورة ${quran.getSurahNameArabic(widget.surahNumber)}';
//     final expectedReciter = 'القارئ : ${_getReciterName()}';

//     return currentTag.album == expectedAlbum &&
//         currentTag.artist == expectedReciter;
//   }

//   Future<void> _handleSameSurahLoaded() async {
//     final lastRead = await _lastReadService.loadLastRead();
//     final lastSurah = lastRead['surah'];
//     final lastAyah = lastRead['ayah'];

//     if (lastSurah == widget.surahNumber && lastAyah != null && lastAyah > 0) {
//       _scheduleSeekToAyah(lastAyah);
//     }
//   }

//   Future<void> _loadNewSurah() async {
//     debugPrint('Loading new surah: ${widget.surahNumber}');

//     // Load last read position first (async)
//     final lastReadFuture = _lastReadService.loadLastRead();

//     // Prepare playlist (this is the heavy operation)
//     await _audioService.prepareSurahPlaylist(
//       surahNumber: widget.surahNumber,
//       reciter: widget.reciter,
//     );

//     // Handle last read position after playlist is ready
//     final lastRead = await lastReadFuture;
//     final lastSurah = lastRead['surah'];
//     final lastAyah = lastRead['ayah'];

//     if (lastSurah == widget.surahNumber && lastAyah != null && lastAyah > 0) {
//       _scheduleSeekToAyah(lastAyah);
//     }
//   }

//   void _scheduleSeekToAyah(int ayah) {
//     // Use a longer delay to ensure audio service is fully ready
//     Future.delayed(const Duration(milliseconds: 500), () async {
//       if (!_isDisposed && mounted) {
//         try {
//           final currentIndex = _audioService.player.currentIndex ?? 0;
//           final targetIndex = ayah - 1;

//           if (currentIndex != targetIndex &&
//               targetIndex >= 0 &&
//               targetIndex < _audioService.player.sequence.length) {
//             await _audioService.seek(Duration.zero, index: targetIndex);
//           }
//         } catch (e) {
//           debugPrint('Error seeking to ayah $ayah: $e');
//         }
//       }
//     });
//   }

//   // Debounced version of ayah change handler to avoid excessive saves
//   void _onAyahChangedDebounced() {
//     final currentAyah = _audioService.currentAyah;

//     // Skip if same ayah or invalid
//     if (currentAyah == null || currentAyah == _lastSavedAyah) return;

//     // Cancel previous timer
//     _ayahChangeDebouncer?.cancel();

//     // Debounce the save operation
//     _ayahChangeDebouncer = Timer(const Duration(milliseconds: 500), () {
//       if (!_isDisposed && mounted) {
//         _saveAyahPosition(currentAyah);
//       }
//     });
//   }

//   void _saveAyahPosition(int ayah) {
//     _lastSavedAyah = ayah;
//     _lastReadService.saveLastRead(surah: widget.surahNumber, ayah: ayah);
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     _ayahChangeDebouncer?.cancel();
//     _audioService.removeListener(_onAyahChangedDebounced);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Cache surah name
//     final surahName = quran.getSurahNameArabic(widget.surahNumber);

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(title: Text('سورة $surahName')),
//         body: SurahTextView(surahNumber: widget.surahNumber),
//         bottomNavigationBar: const PlayerControlsWidget(),
//       ),
//     );
//   }
// }
