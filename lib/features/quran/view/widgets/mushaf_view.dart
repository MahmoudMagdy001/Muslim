import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../utils/quran_position_helper.dart';
import 'create_share_tafsir.dart';
import 'tafsir_selection_dialog.dart';
import 'verse_options_menu.dart';

class MushafView extends StatefulWidget {
  const MushafView({
    required this.surahNumber,
    required this.initialPage,
    required this.isArabic,
    required this.localizations,
    this.onPartChanged,
    this.fromPage,
    this.toPage,
    super.key,
  });

  final int surahNumber;
  final int initialPage;
  final bool isArabic;
  final AppLocalizations localizations;
  final void Function(int surah, int juz, int hizb)? onPartChanged;
  final int? fromPage;
  final int? toPage;

  @override
  State<MushafView> createState() => _MushafViewState();
}

class _MushafViewState extends State<MushafView> {
  late PageController _pageController;
  StreamSubscription? _playerSub;
  final ValueNotifier<int?> currentAyahNotifier = ValueNotifier(null);
  final ValueNotifier<int?> currentSurahNotifier = ValueNotifier(null);
  final TafsirRepository _tafsirRepository = TafsirRepository();
  final Map<String, GlobalKey> _ayahKeys = {};

  @override
  void initState() {
    super.initState();
    // Use the absolute page number based on boundaries
    // The initialPage passed from quran package is 1-based absolute (1-604)
    // If fromPage is set, our page view maps index 0 to fromPage.

    int initialIndex;
    if (widget.fromPage != null) {
      initialIndex = widget.initialPage - widget.fromPage!;
    } else {
      initialIndex = widget.initialPage - 1;
    }

    _pageController = PageController(initialPage: initialIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _playerSub ??= context.read<QuranPlayerCubit>().stream.listen((state) {
      if (!mounted) return;
      final newAyah = state.currentAyah;
      final newSurah = state.currentSurah;

      if (newAyah != null && newSurah != null) {
        if (newAyah != currentAyahNotifier.value ||
            newSurah != currentSurahNotifier.value) {
          currentAyahNotifier.value = newAyah;
          currentSurahNotifier.value = newSurah;

          if (newSurah == widget.surahNumber) {
            // Note: We might need to handle external Surah changes better if we want to support
            // continuous reading AND external navigation.
            // For now, if the player moves to a verse, we jump there.
            // But with continuous reading, `widget.surahNumber` might be just the *initial* surah.
            // We should use currentSurahNotifier logic locally.

            final page = quran.getPageNumber(newSurah, newAyah);
            int targetIndex;

            if (widget.fromPage != null) {
              targetIndex = page - widget.fromPage!;
            } else {
              targetIndex = page - 1;
            }

            if (_pageController.hasClients) {
              if ((_pageController.page?.round() ?? 0) != targetIndex) {
                _pageController
                    .animateToPage(
                      targetIndex,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    )
                    .then((_) {
                      _scrollToCurrentAyah();
                    });
              } else {
                _scrollToCurrentAyah();
              }
            }
          }
        }
      }
    });

    final playerState = context.read<QuranPlayerCubit>().state;
    if (playerState.currentSurah == widget.surahNumber &&
        playerState.currentAyah != null) {
      currentAyahNotifier.value = playerState.currentAyah;
      currentSurahNotifier.value = playerState.currentSurah;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final page = quran.getPageNumber(
          playerState.currentSurah!,
          playerState.currentAyah!,
        );

        int targetIndex;
        if (widget.fromPage != null) {
          targetIndex = page - widget.fromPage!;
        } else {
          targetIndex = page - 1;
        }

        if (_pageController.hasClients) {
          if ((_pageController.page?.round() ?? 0) != targetIndex) {
            _pageController.jumpToPage(targetIndex);
          }
          // Use a small delay to ensure page content is built before scrolling to ayah
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              _scrollToCurrentAyah();
            }
          });
        }
      });
    }
  }

  void _scrollToCurrentAyah() {
    final currentAyah = currentAyahNotifier.value;
    final currentSurah = currentSurahNotifier.value;
    if (currentAyah == null || currentSurah == null) return;

    final key = _ayahKeys['${currentSurah}_$currentAyah'];
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
  void dispose() {
    _playerSub?.cancel();
    _pageController.dispose();
    currentAyahNotifier.dispose();
    currentSurahNotifier.dispose();
    super.dispose();
  }

  // Performance Optimization: Extracted gesture recognition logic
  // into the MushafPageContent implementation.
  Future<void> _onAyahTap(
    int surah,
    int ayah,
    String text,
    Offset position,
  ) async {
    final selected = await VerseOptionsMenu.show(
      context,
      position: position,
      localizations: widget.localizations,
    );

    if (selected == 'play') {
      _handlePlay(surah, ayah);
    } else if (selected == 'bookmark') {
      _handleBookmark(surah, ayah, text);
    } else if (selected == 'tafseer') {
      await _handleTafsir(surah, ayah, text);
    }
  }

  // Removed old _createGestureRecognizer as it's now handled in MushafPageContent.

  void _handlePlay(int surah, int ayah) {
    if (mounted) {
      context.read<QuranPlayerCubit>().seek(
        Duration.zero,
        index: ayah - 1,
        surah: surah,
      );
      context.read<QuranPlayerCubit>().play();
    }
  }

  void _handleBookmark(int surah, int ayah, String text) {
    if (mounted) {
      context.read<BookmarksCubit>().addBookmark(
        surah: surah,
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

  Future<void> _handleTafsir(int surah, int ayah, String text) async {
    if (!mounted) return;

    final Map<String, dynamic>? selectedTafsir =
        await TafsirSelectionDialog.show(
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
      surah,
      ayah,
    );
    final selectedTafsirName = widget.isArabic
        ? selectedTafsir['name_ar']
        : selectedTafsir['name_en'];
    final surahName = widget.isArabic
        ? quran.getSurahNameArabic(surah)
        : quran.getSurahName(surah);

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
                  style: GoogleFonts.amiri().copyWith(
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
    final int effectiveItemCount;
    if (widget.fromPage != null && widget.toPage != null) {
      effectiveItemCount = widget.toPage! - widget.fromPage! + 1;
    } else {
      effectiveItemCount = 604;
    }

    return PageView.builder(
      controller: _pageController,
      reverse: widget.isArabic,
      itemCount: effectiveItemCount,
      onPageChanged: (index) {
        final int pageNumber;
        if (widget.fromPage != null) {
          pageNumber = widget.fromPage! + index;
        } else {
          pageNumber = index + 1;
        }

        // Find which Surah this page belongs to (or predominantly belongs to)
        // quran package doesn't have a direct "getSurahFromPage", but getPageData returns verses.
        // We can take the first verse's surah.
        final pageData = quran.getPageData(pageNumber);
        if (pageData.isNotEmpty) {
          final firstVerse = pageData.first as Map<String, dynamic>;
          final surahNum = firstVerse['surah'] as int;
          final startAyah = firstVerse['start'] as int;

          final juzNum = getJuzForAyah(surahNum, startAyah);
          final hizbNum = getHizbForAyah(surahNum, startAyah);

          widget.onPartChanged?.call(surahNum, juzNum, hizbNum);
        }
      },
      itemBuilder: (context, index) {
        final int pageNumber;
        if (widget.fromPage != null) {
          pageNumber = widget.fromPage! + index;
        } else {
          pageNumber = index + 1;
        }

        final pageData = quran.getPageData(pageNumber);

        return SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(
            start: 8.toW,
            end: 8.toW,
            top: 16.toH,
            bottom: 8.toH,
          ),
          child: Column(
            children: [
              Text(
                '${widget.isArabic ? 'صفحة' : 'Page'} ${convertToArabicNumbers(pageNumber.toString())}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.theme.colorScheme.onSurface,
                ),
              ),
              const Divider(),
              ValueListenableBuilder<int?>(
                valueListenable: currentAyahNotifier,
                builder: (context, currentAyah, _) =>
                    ValueListenableBuilder<int?>(
                      valueListenable: currentSurahNotifier,
                      builder: (context, currentSurah, _) => RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.amiri().copyWith(
                            fontSize: 22.toSp,
                            height: 2.0,
                            color: context.textTheme.bodyLarge?.color,
                          ),
                          children: pageData.map((data) {
                            final Map<String, dynamic> rowData =
                                data as Map<String, dynamic>;
                            final surah = rowData['surah'] as int;
                            final start = rowData['start'] as int;
                            final end = rowData['end'] as int;
                            final spans = <InlineSpan>[];

                            for (int ayah = start; ayah <= end; ayah++) {
                              final isCurrent =
                                  ayah == currentAyah && surah == currentSurah;
                              final text = quran.getVerse(surah, ayah);
                              final endSymbol = quran.getVerseEndSymbol(
                                ayah,
                                arabicNumeral: widget.isArabic,
                              );

                              final keyString = '${surah}_$ayah';
                              final key = _ayahKeys.putIfAbsent(
                                keyString,
                                () => GlobalKey(),
                              );

                              spans
                                ..add(
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.top,
                                    child: SizedBox(
                                      key: key,
                                      width: 0,
                                      height: 0,
                                    ),
                                  ),
                                )
                                ..add(
                                  TextSpan(
                                    text: '$text ',
                                    style: TextStyle(
                                      color: isCurrent
                                          ? context.colorScheme.error
                                          : null,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTapDown = (details) {
                                        _onAyahTap(
                                          surah,
                                          ayah,
                                          text,
                                          details.globalPosition,
                                        );
                                      },
                                  ),
                                )
                                ..add(TextSpan(text: '$endSymbol '));
                            }
                            return TextSpan(children: spans);
                          }).toList(),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
