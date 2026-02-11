import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/base_app_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../repository/tafsir_repository.dart';
import '../../viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import '../../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import 'create_share_tafsir.dart';
import 'surah_text_content.dart';
import 'tafsir_selection_dialog.dart';
import 'verse_options_menu.dart';

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
  final ScrollController _scrollController = ScrollController();
  final TafsirRepository _tafsirRepository = TafsirRepository();
  final ValueNotifier<int?> currentAyahNotifier = ValueNotifier(null);
  final Map<int, GlobalKey> _ayahKeys = {};
  StreamSubscription? _playerSub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((
      playerState,
    ) {
      final newAyah = playerState.currentAyah;
      final newSurah = playerState.currentSurah;
      if (!mounted) return;
      if (newSurah == widget.surahNumber &&
          newAyah != null &&
          newAyah != currentAyahNotifier.value) {
        currentAyahNotifier.value = newAyah;
        _scrollToAyah(newAyah);
      }
    });

    final playerState = context.read<QuranPlayerCubit>().state;
    if (playerState.currentSurah == widget.surahNumber &&
        playerState.currentAyah != null) {
      currentAyahNotifier.value = playerState.currentAyah;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToAyah(playerState.currentAyah!);
      });
    } else if (widget.startAyah != null && widget.startAyah! > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Small delay to ensure layout is complete
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            _scrollToAyah(widget.startAyah!);
          }
        });
      });
    }
  }

  void _scrollToAyah(int ayahNumber) {
    final key = _ayahKeys[ayahNumber];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      alignment: 0.2, // Adjust alignment to center the ayah better
    );
  }

  @override
  void dispose() {
    _playerSub?.cancel();
    _scrollController.dispose();
    currentAyahNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleAyahTap(int ayah, String text, Offset position) async {
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
  }

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
                  color: Colors.white,
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
                    color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    const scrollPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);

    return SingleChildScrollView(
      controller: _scrollController,
      padding: scrollPadding,
      child: SurahTextContent(
        surahNumber: widget.surahNumber,
        isArabic: widget.isArabic,
        currentAyahNotifier: currentAyahNotifier,
        ayahKeys: _ayahKeys,
        onAyahTap: _handleAyahTap,
      ),
    );
  }
}
