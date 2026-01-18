// widgets/surah_text_view_horizontal.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'surah_text_content.dart';

import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/base_app_dialog.dart';
import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../repository/tafsir_repository.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'create_share_tafsir.dart';
import 'verse_options_menu.dart';
import 'tafsir_selection_dialog.dart';
import '../../../../core/utils/responsive_helper.dart';

class SurahTextView extends StatefulWidget {
  const SurahTextView({
    required this.surahNumber,
    required this.isArabic,
    required this.localizations,
    this.startAyah,
    super.key,
  });

  final int surahNumber;
  final int? startAyah;
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  State<SurahTextView> createState() => _SurahTextViewState();
}

class _SurahTextViewState extends State<SurahTextView> {
  final ScrollController _controller = ScrollController();
  final TafsirRepository _tafsirRepository = TafsirRepository();
  final ValueNotifier<int?> currentAyahNotifier = ValueNotifier(null);
  StreamSubscription? _playerSub;
  final Map<int, GlobalKey> _ayahKeys = {};

  // Performance Optimization: Removed unused cachedSpans and cached surah numbers
  // to reduce memory overhead and rely on widget lifecycle.

  @override
  void initState() {
    super.initState();
    _generateKeys();
  }

  @override
  void didUpdateWidget(SurahTextView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surahNumber != widget.surahNumber) {
      _generateKeys();
    }
  }

  void _generateKeys() {
    _ayahKeys.clear();
    final ayahCount = quran.getVerseCount(widget.surahNumber);
    for (int i = 1; i <= ayahCount; i++) {
      _ayahKeys[i] = GlobalKey();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      final newAyah = playerState.currentAyah;
      if (!mounted) return;
      if (newAyah != null && newAyah != currentAyahNotifier.value) {
        currentAyahNotifier.value = newAyah;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToCurrentAyah();
        });
      }
    });

    if (widget.startAyah != null && widget.startAyah! > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToAyah(widget.startAyah!);
      });
    }
  }

  void _scrollToAyah(int ayahNumber) {
    final key = _ayahKeys[ayahNumber];
    if (key == null) return;

    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 200),
      alignment: 0.4,
    );
  }

  @override
  void dispose() {
    _playerSub?.cancel();
    _controller.dispose();
    currentAyahNotifier.dispose();
    super.dispose();
  }

  /// Performance Optimization: Isolated heavy text building in SurahTextContent.
  /// This ensures that only the text widget rebuilds when currentAyah changes,
  /// rather than the entire SurahTextView state.
  Widget _buildContent(BuildContext context) => SurahTextContent(
    surahNumber: widget.surahNumber,
    isArabic: widget.isArabic,
    currentAyahNotifier: currentAyahNotifier,
    ayahKeys: _ayahKeys,
    onAyahTap: (ayah, text, position) async {
      final selected = await VerseOptionsMenu.show(
        context,
        position: position,
        localizations: widget.localizations,
      );

      if (selected == 'play') {
        _handlePlay(ayah);
      } else if (selected == 'bookmark') {
        _handleBookmark(ayah, text);
      } else if (selected == 'tafseer') {
        await _handleTafsir(ayah, text);
      }
    },
  );

  void _handlePlay(int ayah) {
    if (mounted) {
      context.read<QuranPlayerCubit>().seek(Duration.zero, index: ayah - 1);
      context.read<QuranPlayerCubit>().play();
    }
  }

  void _handleBookmark(int ayah, String text) {
    if (mounted) {
      context.read<BookmarksCubit>().addBookmark(
        surah: widget.surahNumber,
        ayah: ayah,
        ayahText: text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${widget.localizations.bookmarkVerseSuccess} ${widget.isArabic ? convertToArabicNumbers(ayah.toString()) : ayah}',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleTafsir(int ayah, String text) async {
    if (!mounted) return;

    final selectedTafsir = await TafsirSelectionDialog.show(
      context,
      localizations: widget.localizations,
      isArabic: widget.isArabic,
    );

    if (selectedTafsir == null) return;

    if (mounted) {
      BaseAppDialog.showLoading(context);
    }
    final tafsirText = await _tafsirRepository.fetchTafsirById(
      selectedTafsir['id'],
      widget.surahNumber,
      ayah,
    );
    final selectedTafsirName = widget.isArabic
        ? selectedTafsir['name_ar']
        : selectedTafsir['name_en'];
    final surahName = widget.isArabic
        ? quran.getSurahNameArabic(widget.surahNumber)
        : quran.getSurahName(widget.surahNumber);

    if (mounted) Navigator.pop(context);

    if (mounted) {
      showCustomModalBottomSheet(
        context: context,
        isScrollControlled: true,
        minChildSize: 0.3,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$selectedTafsirName - ${widget.isArabic ? 'للآية رقم ${convertToArabicNumbers(ayah.toString())} - سورة $surahName' : 'Verse Number $ayah - Surah $surahName'}',
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 20.toH),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontSize: 22.toSp,
                    height: 2.0,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 10.toH),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  tafsirText ?? widget.localizations.emptyTafsir,
                  textAlign: TextAlign.justify,
                  style: context.textTheme.titleMedium?.copyWith(height: 1.7),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 15,
                ),
                child: SizedBox(
                  height: 52.toH,
                  child: ElevatedButton(
                    onPressed: () async {
                      await createAndShareTafsirImage(
                        surahName: surahName,
                        ayahNumber: ayah,
                        ayahText: text,
                        tafsirTitle: selectedTafsirName,
                        tafsirText: tafsirText ?? '',
                        isArabic: widget.isArabic,
                        context: context,
                      );
                    },
                    child: Text(widget.localizations.shareTafsir),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _scrollToCurrentAyah() {
    final currentAyah = currentAyahNotifier.value;
    if (currentAyah == null) return;

    final key = _ayahKeys[currentAyah];
    if (key == null) return;

    final ctx = key.currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      alignment: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Performance Optimization: Extracted paddings to static constants or local variables
    // to avoid re-allocation during rebuilds.
    const scrollPadding = EdgeInsetsDirectional.only(
      start: 6.0,
      end: 18.0,
      top: 5.0,
      bottom: 5.0,
    );

    return Scrollbar(
      controller: _controller,
      child: SingleChildScrollView(
        controller: _controller,
        padding: scrollPadding,
        child: _buildContent(context),
      ),
    );
  }
}
