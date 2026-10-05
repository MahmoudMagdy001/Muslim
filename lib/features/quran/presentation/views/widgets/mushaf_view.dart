import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/features/quran/data/repositories/tafsir_repository.dart';
import 'package:muslim/features/quran/data/services/quran_service.dart';
import 'package:muslim/features/quran/presentation/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_state.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';
import 'package:muslim/features/quran/presentation/views/utils/quran_position_helper.dart';
import 'package:muslim/features/quran/presentation/views/widgets/mushaf_page.dart';
import 'package:muslim/features/quran/presentation/views/widgets/tafsir_bottom_sheet.dart';
import 'package:muslim/features/quran/presentation/views/widgets/tafsir_selection_dialog.dart';
import 'package:muslim/features/quran/presentation/views/widgets/verse_options_menu.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

export 'package:muslim/features/quran/presentation/views/widgets/mushaf_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MushafView
// ─────────────────────────────────────────────────────────────────────────────

class MushafView extends StatefulWidget {
  const MushafView({
    required this.surahNumber,
    required this.initialPage,
    required this.localizations,
    this.readerSettingsNotifier,
    this.onPartChanged,
    this.fromPage,
    this.toPage,
    super.key,
  });

  final int surahNumber;
  final int initialPage;
  final AppLocalizations localizations;
  final ValueNotifier<QuranReaderSettings>? readerSettingsNotifier;
  final void Function(int surah, int juz, int hizb)? onPartChanged;
  final int? fromPage;
  final int? toPage;

  @override
  State<MushafView> createState() => _MushafViewState();
}

class _MushafViewState extends State<MushafView> {
  late final PageController _pageController;
  StreamSubscription<QuranPlayerState>? _playerSub;

  final ValueNotifier<int?> _currentAyahNotifier = ValueNotifier(null);
  final ValueNotifier<int?> _currentSurahNotifier = ValueNotifier(null);

  final TafsirRepository _tafsirRepository = getIt<TafsirRepository>();

  /// Guard preventing double animateToPage calls (double-seek prevention).
  bool _isBusy = false;

  /// Flag set while the audio player drives page animation so onPageChanged
  /// does not overwrite lastPlayed.
  bool _isPlayerNavigating = false;

  // ── Helpers ────────────────────────────────────────────────────────────────

  int _toIndex(int absolutePage) =>
      widget.fromPage != null
          ? absolutePage - widget.fromPage!
          : absolutePage - 1;

  int _maxIndex() =>
      (widget.fromPage != null && widget.toPage != null)
          ? widget.toPage! - widget.fromPage!
          : 603;

  int _currentIndex() =>
      _pageController.page?.round() ?? _pageController.initialPage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    // Single source of truth for page navigation
    _pageController = PageController(initialPage: _toIndex(widget.initialPage));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _subscribeToPlayer();
    });
  }

  void _subscribeToPlayer() {
    final bloc = context.read<QuranPlayerBloc>();

    final initial = bloc.state;
    if (initial.currentSurah != null && initial.currentAyah != null) {
      _currentAyahNotifier.value = initial.currentAyah;
      _currentSurahNotifier.value = initial.currentSurah;
    }

    _playerSub = bloc.stream
        .where((s) => s.currentSurah != null && s.currentAyah != null)
        .distinct(
          (a, b) =>
              a.currentAyah == b.currentAyah && a.currentSurah == b.currentSurah,
        )
        .listen(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged(QuranPlayerState state) {
    if (!mounted) return;

    final newAyah = state.currentAyah!;
    final newSurah = state.currentSurah!;

    final verseCount = quran.getVerseCount(newSurah);
    if (newAyah < 1 || newAyah > verseCount) return;

    _currentAyahNotifier.value = newAyah;
    _currentSurahNotifier.value = newSurah;

    if (_isBusy) return;

    final targetIndex = _toIndex(quran.getPageNumber(newSurah, newAyah));
    final maxIdx = _maxIndex();
    if (targetIndex < 0 || targetIndex > maxIdx) return;
    if (_currentIndex() == targetIndex) return;

    _isBusy = true;
    _isPlayerNavigating = true;

    unawaited(
      _pageController
          .animateToPage(
            targetIndex,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          )
          .whenComplete(() {
            _isBusy = false;
            _isPlayerNavigating = false;
          }),
    );
  }

  void _onPageChanged(int index) {
    final pageNumber = widget.fromPage != null
        ? widget.fromPage! + index
        : index + 1;

    final pageData = quran.getPageData(pageNumber);
    if (pageData.isEmpty) return;

    final firstVerse = pageData.first as Map<String, dynamic>;
    final surahNum = firstVerse['surah'] as int;
    final startAyah = firstVerse['start'] as int;

    widget.onPartChanged?.call(
      surahNum,
      getJuzForAyah(surahNum, startAyah),
      getHizbForAyah(surahNum, startAyah),
    );

    if (!_isPlayerNavigating) {
      unawaited(
        getIt<QuranService>().saveLastPlayed(surah: surahNum, verse: startAyah),
      );
    }
  }

  @override
  void dispose() {
    unawaited(_playerSub?.cancel());
    _pageController.dispose();
    _currentAyahNotifier.dispose();
    _currentSurahNotifier.dispose();
    super.dispose();
  }

  // ── Ayah interaction ───────────────────────────────────────────────────────

  Future<void> _onAyahTap(
    int surah,
    int ayah,
    String text,
    Offset position,
  ) async {
    final selected = await VerseOptionsMenu.show(
      context,
      position: position,
      surahNumber: surah,
      ayahNumber: ayah,
      verseText: text,
      localizations: widget.localizations,
    );

    if (!mounted) return;
    switch (selected) {
      case 'play':
        _handlePlay(surah, ayah);
      case 'bookmark':
        _handleBookmark(surah, ayah, text);
      case 'tafseer':
        await _handleTafsir(surah, ayah, text);
    }
  }

  void _handlePlay(int surah, int ayah) {
    if (!mounted) return;
    unawaited(context.read<QuranPlayerBloc>().seekToAyah(surah, ayah));
    unawaited(context.read<QuranPlayerBloc>().play());
  }

  void _handleBookmark(int surah, int ayah, String text) {
    if (!mounted) return;
    unawaited(
      context.read<BookmarksBloc>().addBookmark(
        surah: surah,
        ayah: ayah,
        ayahText: text,
      ),
    );
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.localizations.bookmarkVerseSuccess} '
          '${isArabic ? convertToArabicNumbers(ayah.toString()) : ayah}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleTafsir(int surah, int ayah, String text) async {
    if (!mounted) return;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final selectedTafsir = await TafsirSelectionDialog.show(
      context,
      localizations: widget.localizations,
    );
    if (selectedTafsir == null) return;

    if (mounted) {
      unawaited(BaseAppDialog.showLoading(context));
    }

    try {
      final tafsirText = await _tafsirRepository.fetchTafsirById(
        selectedTafsir['id'] as int,
        surah,
        ayah,
      );
      final selectedTafsirName =
          (isArabic ? selectedTafsir['name_ar'] : selectedTafsir['name_en'])
              as String;
      final surahName =
          isArabic ? quran.getSurahNameArabic(surah) : quran.getSurahName(surah);

      if (mounted) Navigator.pop(context);

      if (mounted) {
        unawaited(
          TafsirBottomSheet.show(
            context,
            surahName: surahName,
            ayahNumber: ayah,
            ayahText: text,
            tafsirTitle: selectedTafsirName,
            tafsirText: tafsirText ?? widget.localizations.emptyTafsir,
            localizations: widget.localizations,
          ),
        );
      }
    } on Object catch (_) {
      if (mounted) Navigator.pop(context);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final itemCount = widget.toPage != null && widget.fromPage != null
        ? widget.toPage! - widget.fromPage! + 1
        : 604;

    return PageView.builder(
      controller: _pageController,
      reverse: isArabic,
      itemCount: itemCount,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        final pageNumber = widget.fromPage != null
            ? widget.fromPage! + index
            : index + 1;
        return MushafPage(
          pageNumber: pageNumber,
          currentAyahNotifier: _currentAyahNotifier,
          currentSurahNotifier: _currentSurahNotifier,
          readerSettingsNotifier: widget.readerSettingsNotifier,
          onAyahTap: _onAyahTap,
        );
      },
    );
  }
}
