import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';
import 'package:muslim/features/quran/presentation/views/utils/quran_position_helper.dart';
import 'package:muslim/features/quran/presentation/views/widgets/mushaf_frame_painter.dart';
import 'package:muslim/features/quran/presentation/views/widgets/mushaf_text.dart';
import 'package:muslim/features/quran/presentation/views/widgets/surah_header_banner.dart';
import 'package:quran/quran.dart' as quran;

// ─────────────────────────────────────────────────────────────────────────────
// _MushafPageSegment — helper data structure for Surahs on a single page
// ─────────────────────────────────────────────────────────────────────────────

class _MushafPageSegment {
  const _MushafPageSegment({
    required this.surah,
    required this.start,
    required this.end,
    required this.ayahOrder,
  });

  final int surah;
  final int start;
  final int end;
  final List<(int, int)> ayahOrder;
}

// ─────────────────────────────────────────────────────────────────────────────
// MushafPage — single Quran page with Islamic frame and Surah header banners
// ─────────────────────────────────────────────────────────────────────────────

class MushafPage extends StatefulWidget {
  const MushafPage({
    required this.pageNumber,
    required this.currentAyahNotifier,
    required this.currentSurahNotifier,
    required this.onAyahTap,
    this.readerSettingsNotifier,
    super.key,
  });

  final int pageNumber;
  final ValueNotifier<int?> currentAyahNotifier;
  final ValueNotifier<int?> currentSurahNotifier;
  final ValueNotifier<QuranReaderSettings>? readerSettingsNotifier;
  final void Function(int surah, int ayah, String text, Offset position)
      onAyahTap;

  @override
  State<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends State<MushafPage> {
  late final ScrollController _scrollController;
  late final List<_MushafPageSegment> _segments;
  final Map<String, GlobalKey> _ayahStartKeys = {};
  final Map<String, GlobalKey> _ayahEndKeys = {};
  final Map<String, TapGestureRecognizer> _recognizers = {};
  final Map<String, String> _verseTexts = {};
  final Map<String, String> _endSymbols = {};

  static final _defaultSettings = ValueNotifier(const QuranReaderSettings());

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _buildPageData();

    widget.currentAyahNotifier.addListener(_onActiveAyahChanged);
    widget.currentSurahNotifier.addListener(_onActiveAyahChanged);

    // Initial check: if the target ayah is on this page, jump to it without animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _scrollToCurrentAyah(animated: false);
    });
  }

  @override
  void didUpdateWidget(MushafPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentAyahNotifier != widget.currentAyahNotifier) {
      oldWidget.currentAyahNotifier.removeListener(_onActiveAyahChanged);
      widget.currentAyahNotifier.addListener(_onActiveAyahChanged);
    }
    if (oldWidget.currentSurahNotifier != widget.currentSurahNotifier) {
      oldWidget.currentSurahNotifier.removeListener(_onActiveAyahChanged);
      widget.currentSurahNotifier.addListener(_onActiveAyahChanged);
    }
  }

  void _onActiveAyahChanged() {
    if (!mounted) return;
    _scrollToCurrentAyah(animated: true);
  }

  void _scrollToCurrentAyah({required bool animated}) {
    final curAyah = widget.currentAyahNotifier.value;
    final curSurah = widget.currentSurahNotifier.value;
    if (curAyah == null || curSurah == null) return;

    final keyString = '${curSurah}_$curAyah';
    final startKey = _ayahStartKeys[keyString];
    if (startKey == null) return; // Ayah is not on this page

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final startCtx = startKey.currentContext;
      if (startCtx == null) return;

      final startRenderObject = startCtx.findRenderObject();
      if (startRenderObject is! RenderBox || !startRenderObject.attached) return;

      final scrollable = Scrollable.maybeOf(startCtx);
      if (scrollable == null) return;
      final viewport = scrollable.context.findRenderObject();
      if (viewport is! RenderBox || !viewport.attached) return;

      final startPos =
          startRenderObject.localToGlobal(Offset.zero, ancestor: viewport);
      final viewportHeight = viewport.size.height;

      // Safe reading zone within the viewport
      const topSafeMargin = 28.0;
      final bottomSafeMargin = viewportHeight - 36.0;
      final availableHeight = bottomSafeMargin - topSafeMargin;

      final settings =
          widget.readerSettingsNotifier?.value ?? const QuranReaderSettings();
      final estimatedLineHeight = settings.fontSize.toSp * 2.2;

      var ayahTop = startPos.dy;
      var ayahBottom = ayahTop + estimatedLineHeight;

      final endKey = _ayahEndKeys[keyString];
      final endCtx = endKey?.currentContext;
      final endRenderObject = endCtx?.findRenderObject();

      if (endRenderObject is RenderBox && endRenderObject.attached) {
        final endPos =
            endRenderObject.localToGlobal(Offset.zero, ancestor: viewport);
        ayahBottom = endPos.dy + estimatedLineHeight;
      }

      if (ayahBottom < ayahTop) {
        final temp = ayahTop;
        ayahTop = ayahBottom;
        ayahBottom = temp;
      }

      final ayahHeight = ayahBottom - ayahTop;

      // The ayah is considered fully visible if and only if BOTH its top and bottom
      // are completely within the safe reading margins of the viewport.
      final isFullyVisible =
          ayahTop >= topSafeMargin && ayahBottom <= bottomSafeMargin;

      if (isFullyVisible) return;

      if (!_scrollController.hasClients) return;

      double delta = 0;
      if (ayahHeight <= availableHeight) {
        // Fits completely on screen -> Center the verse in the viewport
        final targetCenter = topSafeMargin + (availableHeight / 2.0);
        final currentCenter = (ayahTop + ayahBottom) / 2.0;
        delta = currentCenter - targetCenter;
      } else {
        // Longer than viewport -> Align top of verse to top safe margin
        delta = ayahTop - topSafeMargin;
      }

      if (delta.abs() < 1.0) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final minScroll = _scrollController.position.minScrollExtent;
      final targetOffset =
          (_scrollController.offset + delta).clamp(minScroll, maxScroll);

      if ((targetOffset - _scrollController.offset).abs() < 1.0) return;

      if (animated) {
        unawaited(
          _scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          ),
        );
      } else {
        _scrollController.jumpTo(targetOffset);
      }
    });
  }

  void _buildPageData() {
    final pageData = quran.getPageData(widget.pageNumber);
    final segments = <_MushafPageSegment>[];

    for (final raw in pageData) {
      final row = raw as Map<String, dynamic>;
      final surah = row['surah'] as int;
      final start = row['start'] as int;
      final end = row['end'] as int;
      final segmentOrder = <(int, int)>[];

      for (var ayah = start; ayah <= end; ayah++) {
        final key = '${surah}_$ayah';
        segmentOrder.add((surah, ayah));
        if (!_recognizers.containsKey(key)) {
          final text = quran.getVerse(surah, ayah);
          _verseTexts[key] = text;
          _endSymbols['${key}_ar'] = quran.getVerseEndSymbol(ayah);
          _endSymbols['${key}_en'] =
              quran.getVerseEndSymbol(ayah, arabicNumeral: false);
          _recognizers[key] = TapGestureRecognizer()
            ..onTapDown = (d) =>
                widget.onAyahTap(surah, ayah, text, d.globalPosition);
        }
      }

      segments.add(
        _MushafPageSegment(
          surah: surah,
          start: start,
          end: end,
          ayahOrder: segmentOrder,
        ),
      );
    }
    _segments = segments;
  }

  @override
  void dispose() {
    widget.currentAyahNotifier.removeListener(_onActiveAyahChanged);
    widget.currentSurahNotifier.removeListener(_onActiveAyahChanged);
    _scrollController.dispose();
    for (final r in _recognizers.values) {
      r.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final pageData = quran.getPageData(widget.pageNumber);
    final firstRow = pageData.isNotEmpty
        ? pageData.first as Map<String, dynamic>
        : null;
    final topSurah = firstRow != null ? firstRow['surah'] as int : 1;
    final topStart = firstRow != null ? firstRow['start'] as int : 1;
    final topJuz = getJuzForAyah(topSurah, topStart);
    final topSurahName = isArabic
        ? quran.getSurahNameArabic(topSurah)
        : quran.getSurahName(topSurah);

    return ValueListenableBuilder<QuranReaderSettings>(
      valueListenable: widget.readerSettingsNotifier ?? _defaultSettings,
      builder: (context, settings, _) {
        final theme = settings.theme;

        return ColoredBox(
          color: theme.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 6.toH),
            child: CustomPaint(
              painter: MushafFramePainter(frameColor: theme.frameColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.toW,
                  vertical: 12.toH,
                ),
                child: Column(
                  children: [
                    // Top header: Surah Name on one side, Juz on the other
                    MushafPageHeader(
                      surahName: topSurahName,
                      juz: topJuz,
                      frameColor: theme.frameColor,
                      isArabic: isArabic,
                    ),
                    Divider(
                      color: theme.frameColor.withValues(alpha: 0.3),
                      height: 10.toH,
                    ),

                    // Middle scrollable page content
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.toW,
                            vertical: 4.toH,
                          ),
                          child: Column(
                            children: [
                              for (final segment in _segments) ...[
                                if (segment.start == 1)
                                  SurahHeaderBanner(
                                    surahNumber: segment.surah,
                                    readerTheme: theme,
                                  ),
                                MushafText(
                                  ayahOrder: segment.ayahOrder,
                                  recognizers: _recognizers,
                                  verseTexts: _verseTexts,
                                  endSymbols: _endSymbols,
                                  ayahStartKeys: _ayahStartKeys,
                                  ayahEndKeys: _ayahEndKeys,
                                  currentAyahNotifier: widget.currentAyahNotifier,
                                  currentSurahNotifier:
                                      widget.currentSurahNotifier,
                                  settings: settings,
                                ),
                                SizedBox(height: 8.toH),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom footer: Page Number badge
                    MushafPageFooter(
                      pageNumber: widget.pageNumber,
                      theme: theme,
                      isArabic: isArabic,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MushafPageHeader — Header showing Surah Name and Juz
// ─────────────────────────────────────────────────────────────────────────────

class MushafPageHeader extends StatelessWidget {
  const MushafPageHeader({
    required this.surahName,
    required this.juz,
    required this.frameColor,
    required this.isArabic,
    super.key,
  });

  final String surahName;
  final int juz;
  final Color frameColor;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 2.toH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isArabic ? 'سُورَةُ $surahName' : 'Surah $surahName',
            style: GoogleFonts.amiri(
              fontSize: 12.toSp,
              fontWeight: FontWeight.bold,
              color: frameColor,
            ),
          ),
          Text(
            isArabic
                ? 'الجُزْءُ ${convertToArabicNumbers(juz.toString())}'
                : 'Juz $juz',
            style: GoogleFonts.amiri(
              fontSize: 12.toSp,
              fontWeight: FontWeight.bold,
              color: frameColor,
            ),
          ),
        ],
      ),
    );
}

// ─────────────────────────────────────────────────────────────────────────────
// MushafPageFooter — Footer showing Page Number badge
// ─────────────────────────────────────────────────────────────────────────────

class MushafPageFooter extends StatelessWidget {
  const MushafPageFooter({
    required this.pageNumber,
    required this.theme,
    required this.isArabic,
    super.key,
  });

  final int pageNumber;
  final QuranReaderTheme theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: 4.toH),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.frameColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.toR),
          border: Border.all(
            color: theme.frameColor.withValues(alpha: 0.4),
            width: 0.8,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.toW,
            vertical: 2.toH,
          ),
          child: Text(
            isArabic
                ? convertToArabicNumbers(pageNumber.toString())
                : pageNumber.toString(),
            style: GoogleFonts.cairo(
              fontSize: 11.toSp,
              fontWeight: FontWeight.bold,
              color: theme.textColor,
            ),
          ),
        ),
      ),
    );
}
