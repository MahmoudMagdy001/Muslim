import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:muslim/core/widgets/custom_modal_sheet.dart';
import 'package:muslim/features/quran/repository/tafsir_repository.dart';
import 'package:muslim/features/quran/view/utils/quran_position_helper.dart';
import 'package:muslim/features/quran/view/widgets/create_share_tafsir.dart';
import 'package:muslim/features/quran/view/widgets/tafsir_selection_dialog.dart';
import 'package:muslim/features/quran/view/widgets/verse_options_menu.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/quran/viewmodel/quran_player_cubit/quran_player_cubit.dart';
import 'package:muslim/features/quran/viewmodel/quran_player_cubit/quran_player_state.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

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
  StreamSubscription<QuranPlayerState>? _playerSub;
  final ValueNotifier<int?> currentAyahNotifier = ValueNotifier(null);
  final ValueNotifier<int?> currentSurahNotifier = ValueNotifier(null);
  final TafsirRepository _tafsirRepository = TafsirRepository();
  final Map<String, GlobalKey> _ayahKeys = {};
  bool _initialScrollDone = false;

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
        // Validate that the ayah is within the valid range for this surah
        final verseCount = quran.getVerseCount(newSurah);
        if (newAyah < 1 || newAyah > verseCount) return;

        if (newAyah != currentAyahNotifier.value ||
            newSurah != currentSurahNotifier.value) {
          currentAyahNotifier.value = newAyah;
          currentSurahNotifier.value = newSurah;

          final page = quran.getPageNumber(newSurah, newAyah);
          int targetIndex;

          if (widget.fromPage != null) {
            targetIndex = page - widget.fromPage!;
          } else {
            targetIndex = page - 1;
          }

          // Only follow if the page is within our range
          final maxIndex = widget.fromPage != null && widget.toPage != null
              ? widget.toPage! - widget.fromPage!
              : 603;
          if (targetIndex >= 0 && targetIndex <= maxIndex) {
            if (_pageController.hasClients) {
              if ((_pageController.page?.round() ?? 0) != targetIndex) {
                unawaited(
                  _pageController
                      .animateToPage(
                        targetIndex,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      )
                      .then((_) {
                        _scrollToCurrentAyah();
                      }),
                );
              } else {
                _scrollToCurrentAyah();
              }
            }
          }
        }
      }
    });

    // Guard: only perform initial scroll positioning once per widget lifetime
    if (!_initialScrollDone) {
      final playerState = context.read<QuranPlayerCubit>().state;
      // Only use player state for initial positioning if it's relevant to this view
      final isRelevantState =
          playerState.currentSurah != null &&
          playerState.currentAyah != null &&
          playerState.currentSurah == widget.surahNumber &&
          playerState.currentAyah! >= 1 &&
          playerState.currentAyah! <=
              quran.getVerseCount(playerState.currentSurah!);
      if (isRelevantState) {
        _initialScrollDone = true;
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
            // Use addPostFrameCallback instead of Future.delayed for deterministic timing
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _scrollToCurrentAyah();
            });
          }
        });
      }
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

    unawaited(
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        alignment: 0.4,
      ),
    );
  }

  @override
  void dispose() {
    unawaited(_playerSub?.cancel());
    _pageController.dispose();
    currentAyahNotifier.dispose();
    currentSurahNotifier.dispose();
    super.dispose();
  }

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

  void _handlePlay(int surah, int ayah) {
    if (mounted) {
      unawaited(context.read<QuranPlayerCubit>().seekToAyah(surah, ayah));
      unawaited(context.read<QuranPlayerCubit>().play());
    }
  }

  void _handleBookmark(int surah, int ayah, String text) {
    if (mounted) {
      unawaited(
        context.read<BookmarksCubit>().addBookmark(
          surah: surah,
          ayah: ayah,
          ayahText: text,
        ),
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

    final selectedTafsir =
        await TafsirSelectionDialog.show(
          context,
          localizations: widget.localizations,
          isArabic: widget.isArabic,
        );

    if (selectedTafsir == null) return;

    if (mounted) {
      await BaseAppDialog.showLoading(context);
    }
    final tafsirText = await _tafsirRepository.fetchTafsirById(
      selectedTafsir['id'] as int,
      surah,
      ayah,
    );
    final selectedTafsirName = (widget.isArabic
        ? selectedTafsir['name_ar']
        : selectedTafsir['name_en']) as String;
    final surahName = widget.isArabic
        ? quran.getSurahNameArabic(surah)
        : quran.getSurahName(surah);

    if (mounted) Navigator.pop(context);

    if (mounted) {
      unawaited(
        showCustomModalBottomSheet<void>(
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
                      await BaseAppDialog.showLoading(
                        context,
                        message: widget.isArabic
                            ? 'جاري إنشاء الصور...'
                            : 'Creating images...',
                      );

                      try {
                        if (!context.mounted) return;
                        final result = await TafsirShareService()
                            .createAndShare(
                              surahName: surahName,
                              ayahNumber: ayah,
                              ayahText: text,
                              tafsirTitle: selectedTafsirName,
                              tafsirText: tafsirText ?? '',
                              isArabic: widget.isArabic,
                              context: context,
                            );

                        if (context.mounted) Navigator.pop(context);

                        if (!result.success && context.mounted) {
                          await BaseAppDialog.show<void>(
                            context,
                            title: widget.isArabic ? '⚠️ خطأ' : '⚠️ Error',
                            contentText: result.errorMessage ?? '',
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(widget.isArabic ? 'موافق' : 'OK'),
                              ),
                            ],
                          );
                        }
                      } on Object catch (e) {
                        if (context.mounted && Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                        if (context.mounted) {
                          await BaseAppDialog.show<void>(
                            context,
                            title: widget.isArabic ? '⚠️ خطأ' : '⚠️ Error',
                            contentText: e.toString().replaceAll(
                              'Exception: ',
                              '',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(widget.isArabic ? 'موافق' : 'OK'),
                              ),
                            ],
                          );
                        }
                      }
                    },
                    child: Text(widget.localizations.shareTafsir),
                  ),
                ),
              ),
            ],
          ),
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

        return MushafPage(
          pageNumber: pageNumber,
          isArabic: widget.isArabic,
          currentAyahNotifier: currentAyahNotifier,
          currentSurahNotifier: currentSurahNotifier,
          ayahKeys: _ayahKeys,
          onAyahTap: _onAyahTap,
        );
      },
    );
  }
}

class MushafPage extends StatefulWidget {
  const MushafPage({
    required this.pageNumber,
    required this.isArabic,
    required this.currentAyahNotifier,
    required this.currentSurahNotifier,
    required this.ayahKeys,
    required this.onAyahTap,
    super.key,
  });

  final int pageNumber;
  final bool isArabic;
  final ValueNotifier<int?> currentAyahNotifier;
  final ValueNotifier<int?> currentSurahNotifier;
  final Map<String, GlobalKey> ayahKeys;
  final void Function(int surah, int ayah, String text, Offset position) onAyahTap;

  @override
  State<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends State<MushafPage> {
  late final List<dynamic> _pageData;
  final Map<String, TapGestureRecognizer> _recognizers = {};
  // Pre-cached verse texts so _buildSpans never calls quran.getVerse at paint time
  final Map<String, String> _verseTexts = {};
  // Pre-cached end symbols keyed by ayah number (display-language-independent)
  final Map<String, String> _endSymbols = {};
  // Flat ordered list of (surah, ayah) pairs for _buildSpans iteration
  late final List<(int, int)> _ayahOrder;

  @override
  void initState() {
    super.initState();
    _pageData = quran.getPageData(widget.pageNumber);
    _initData();
  }

  void _initData() {
    final order = <(int, int)>[];
    for (final data in _pageData) {
      final rowData = data as Map<String, dynamic>;
      final surah = rowData['surah'] as int;
      final start = rowData['start'] as int;
      final end = rowData['end'] as int;

      for (var ayah = start; ayah <= end; ayah++) {
        final keyString = '${surah}_$ayah';
        order.add((surah, ayah));
        if (!_recognizers.containsKey(keyString)) {
          final text = quran.getVerse(surah, ayah);
          _verseTexts[keyString] = text;
          // Cache end symbol for both Arabic and non-Arabic numerals
          _endSymbols['${keyString}_ar'] =
              quran.getVerseEndSymbol(ayah);
          _endSymbols['${keyString}_en'] =
              quran.getVerseEndSymbol(ayah, arabicNumeral: false);
          _recognizers[keyString] = TapGestureRecognizer()
            ..onTapDown = (details) {
              widget.onAyahTap(surah, ayah, text, details.globalPosition);
            };
        }
      }
    }
    _ayahOrder = order;
  }

  @override
  void dispose() {
    for (final recognizer in _recognizers.values) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsetsDirectional.only(
      start: 8.toW,
      end: 8.toW,
      top: 16.toH,
      bottom: 8.toH,
    ),
    child: Column(
      children: [
        Text(
          '${widget.isArabic ? 'صفحة' : 'Page'} ${convertToArabicNumbers(widget.pageNumber.toString())}',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.theme.colorScheme.onSurface,
          ),
        ),
        const Divider(),
        // Only the highlight-color layer rebuilds on ayah changes; text/symbols are pre-cached.
        _OptimizedMushafText(
          ayahOrder: _ayahOrder,
          isArabic: widget.isArabic,
          recognizers: _recognizers,
          verseTexts: _verseTexts,
          endSymbols: _endSymbols,
          ayahKeys: widget.ayahKeys,
          currentAyahNotifier: widget.currentAyahNotifier,
          currentSurahNotifier: widget.currentSurahNotifier,
        ),
      ],
    ),
  );
}

// Optimized widget: rebuilds only the text-highlight layer on ayah changes.
// All verse text, end-symbols and recognizers are pre-cached by the parent State.
class _OptimizedMushafText extends StatelessWidget {
  const _OptimizedMushafText({
    required this.ayahOrder,
    required this.isArabic,
    required this.recognizers,
    required this.verseTexts,
    required this.endSymbols,
    required this.ayahKeys,
    required this.currentAyahNotifier,
    required this.currentSurahNotifier,
  });

  /// Flat ordered list of (surah, ayah) pairs — pre-built in initState.
  final List<(int, int)> ayahOrder;
  final bool isArabic;
  final Map<String, TapGestureRecognizer> recognizers;
  final Map<String, String> verseTexts;
  /// Pre-cached end symbols: key = '${surah}_${ayah}_ar' or '_en'.
  final Map<String, String> endSymbols;
  final Map<String, GlobalKey> ayahKeys;
  final ValueNotifier<int?> currentAyahNotifier;
  final ValueNotifier<int?> currentSurahNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int?>(
    valueListenable: currentAyahNotifier,
    builder: (context, currentAyah, _) => ValueListenableBuilder<int?>(
      valueListenable: currentSurahNotifier,
      builder: (context, currentSurah, _) {
        final spans = _buildSpans(context, currentSurah, currentAyah);
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.amiri().copyWith(
              fontSize: 22.toSp,
              height: 2.0,
              color: context.textTheme.bodyLarge?.color,
            ),
            children: spans,
          ),
        );
      },
    ),
  );

  /// Assembles spans using only pre-cached data — no Quran package calls at paint time.
  List<InlineSpan> _buildSpans(
    BuildContext context,
    int? currentSurah,
    int? currentAyah,
  ) {
    final symbolSuffix = isArabic ? '_ar' : '_en';
    final spans = <InlineSpan>[];

    for (final (surah, ayah) in ayahOrder) {
      final isCurrent = ayah == currentAyah && surah == currentSurah;
      final keyString = '${surah}_$ayah';
      final text = verseTexts[keyString] ?? '';
      final endSymbol = endSymbols['$keyString$symbolSuffix'] ?? '';

      // Ensure key exists for scrolling
      final key = ayahKeys.putIfAbsent(keyString, GlobalKey.new);

      spans
        ..add(
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: SizedBox.shrink(key: key),
          ),
        )
        ..add(
          TextSpan(
            text: '$text ',
            style: TextStyle(
              color: isCurrent ? context.colorScheme.error : null,
              backgroundColor: isCurrent
                  ? context.colorScheme.error.withValues(alpha: 0.1)
                  : null,
            ),
            recognizer: recognizers[keyString],
          ),
        )
        ..add(TextSpan(text: '$endSymbol '));
    }
    return spans;
  }
}
