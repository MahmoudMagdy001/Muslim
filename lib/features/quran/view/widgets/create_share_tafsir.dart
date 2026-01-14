import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

/// Result of a tafsir image share operation.
class TafsirShareResult {
  const TafsirShareResult({
    required this.success,
    this.errorMessage,
    this.imagesCreated = 0,
  });

  final bool success;
  final String? errorMessage;
  final int imagesCreated;
}

/// Service responsible for generating tafsir images and sharing them.
///
/// Handles text splitting, widget-to-image capture, temp file management,
/// and invoking the platform share sheet.
class TafsirShareService {
  TafsirShareService({ScreenshotController? screenshotController})
    : _screenshotController = screenshotController ?? ScreenshotController();

  final ScreenshotController _screenshotController;

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Creates tafsir images and opens the share sheet.
  ///
  /// The caller is responsible for showing/dismissing loading indicators and
  /// handling errors via the returned [TafsirShareResult].
  Future<TafsirShareResult> createAndShare({
    required String surahName,
    required int ayahNumber,
    required String ayahText,
    required String tafsirTitle,
    required String tafsirText,
    required bool isArabic,
    required BuildContext context,
  }) async {
    if (tafsirText.trim().isEmpty) {
      return TafsirShareResult(
        success: false,
        errorMessage: isArabic ? 'نص التفسير فارغ' : 'Tafsir text is empty',
      );
    }

    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final titleLargeStyle = themeData.textTheme.titleLarge;
    final titleMediumStyle = themeData.textTheme.titleMedium;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    final tafsirParts = _splitText(tafsirText);
    if (tafsirParts.isEmpty) {
      return TafsirShareResult(
        success: false,
        errorMessage: isArabic
            ? 'فشل تقسيم نص التفسير'
            : 'Failed to split tafsir text',
      );
    }

    await _clearTemporaryImages();

    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeName = surahName.replaceAll(RegExp(r'[^\w\s]+'), '');
    final imageFiles = <File>[];

    // --- First page (Basmala + Ayah) ---
    final firstPage = _TafsirFirstPage(
      surahName: surahName,
      ayahNumber: ayahNumber,
      ayahText: ayahText,
      tafsirTitle: tafsirTitle,
      titleLargeStyle: titleLargeStyle,
      titleMediumStyle: titleMediumStyle,
    );

    final firstFile = await _captureWidget(
      widget: firstPage,
      textDirection: textDirection,
      themeData: themeData,
      mediaQueryData: mediaQueryData,
      path: '${dir.path}/tafsir_${safeName}_${ayahNumber}_0_$timestamp.png',
    );
    imageFiles.add(firstFile);

    // --- Tafsir content pages ---
    for (var i = 0; i < tafsirParts.length; i++) {
      final page = _TafsirContentPage(
        tafsirPart: tafsirParts[i],
        partIndex: i,
        totalParts: tafsirParts.length,
        isArabic: isArabic,
      );

      final file = await _captureWidget(
        widget: page,
        textDirection: textDirection,
        themeData: themeData,
        mediaQueryData: mediaQueryData,
        path:
            '${dir.path}/tafsir_${safeName}_${ayahNumber}_${i + 1}_$timestamp.png',
      );
      imageFiles.add(file);
    }

    // --- Share ---
    final shareText = _buildShareText(
      surahName: surahName,
      ayahNumber: ayahNumber,
      isArabic: isArabic,
      totalImages: imageFiles.length,
    );

    await SharePlus.instance.share(
      ShareParams(
        files: imageFiles.map((f) => XFile(f.path)).toList(),
        text: shareText,
        subject: isArabic ? 'تفسير القرآن الكريم' : 'Quran Tafsir',
      ),
    );

    return TafsirShareResult(success: true, imagesCreated: imageFiles.length);
  }

  // ---------------------------------------------------------------------------
  // Capture helpers
  // ---------------------------------------------------------------------------

  Future<File> _captureWidget({
    required Widget widget,
    required TextDirection textDirection,
    required ThemeData themeData,
    required MediaQueryData mediaQueryData,
    required String path,
  }) async {
    final bytes = await _screenshotController.captureFromWidget(
      Theme(
        data: themeData,
        child: MediaQuery(
          data: mediaQueryData,
          child: Directionality(
            textDirection: textDirection,
            child: Scaffold(backgroundColor: Colors.white, body: widget),
          ),
        ),
      ),
      delay: const Duration(milliseconds: 50),
      pixelRatio: 2.0,
    );

    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }

  // ---------------------------------------------------------------------------
  // Text splitting
  // ---------------------------------------------------------------------------

  static const int _maxCharsPerPart = 1320;

  List<String> _splitText(String text) {
    final cleaned = text.trim().replaceAll(RegExp(r'\s+'), ' ');

    if (cleaned.isEmpty) return [''];
    if (cleaned.length <= _maxCharsPerPart) return [cleaned];

    final parts = <String>[];
    var start = 0;

    while (start < cleaned.length) {
      final end = start + _maxCharsPerPart;

      if (end >= cleaned.length) {
        final remaining = cleaned.substring(start).trim();
        if (remaining.isNotEmpty) parts.add(remaining);
        break;
      }

      final cutIndex = _findBestCutIndex(cleaned, start, end);
      final part = cleaned.substring(start, cutIndex).trim();
      if (part.isNotEmpty) parts.add(part);

      start = cutIndex;
      // Skip leading spaces
      while (start < cleaned.length && cleaned[start] == ' ') {
        start++;
      }
    }

    return parts.isEmpty ? [cleaned] : parts;
  }

  int _findBestCutIndex(String text, int start, int end) {
    // Prefer sentence-ending punctuation
    final sentenceEnd = text.lastIndexOf(RegExp(r'[.؟!]'), end);
    if (sentenceEnd > start && (end - sentenceEnd) < 100) {
      return sentenceEnd + 1;
    }

    // Then commas / semicolons
    final commaEnd = text.lastIndexOf(RegExp(r'[،,;]'), end);
    if (commaEnd > start && (end - commaEnd) < 100) {
      return commaEnd + 1;
    }

    // Then spaces
    final spaceEnd = text.lastIndexOf(' ', end);
    if (spaceEnd > start && spaceEnd > start + 100) {
      return spaceEnd + 1;
    }

    return end;
  }

  // ---------------------------------------------------------------------------
  // Utilities
  // ---------------------------------------------------------------------------

  String _buildShareText({
    required String surahName,
    required int ayahNumber,
    required bool isArabic,
    required int totalImages,
  }) {
    if (isArabic) {
      final count = _convertToArabicNumbers(totalImages);
      final suffix = totalImages > 1
          ? '\n(${totalImages == 2 ? 'صورتان' : '$count صور'})'
          : '';
      return '📖 تفسير سورة $surahName - الآية ${_convertToArabicNumbers(ayahNumber)}$suffix';
    }
    final suffix = totalImages > 1 ? '\n($totalImages images)' : '';
    return '📖 Tafsir $surahName - Verse $ayahNumber$suffix';
  }

  static String _convertToArabicNumbers(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((c) {
      final i = english.indexOf(c);
      return i >= 0 ? arabic[i] : c;
    }).join();
  }

  Future<void> _clearTemporaryImages() async {
    try {
      final dir = await getTemporaryDirectory();
      final entities = dir.listSync();
      for (final entity in entities) {
        if (entity is File && entity.path.contains('tafsir_')) {
          try {
            await entity.delete();
          } catch (_) {
            // Best-effort cleanup
          }
        }
      }
    } catch (_) {
      // Best-effort cleanup
    }
  }
}

// =============================================================================
// Private widget classes for image rendering
// =============================================================================

/// Cover page: Surah name, Basmala, Ayah text, and Tafsir title.
class _TafsirFirstPage extends StatelessWidget {
  const _TafsirFirstPage({
    required this.surahName,
    required this.ayahNumber,
    required this.ayahText,
    required this.tafsirTitle,
    this.titleLargeStyle,
    this.titleMediumStyle,
  });

  final String surahName;
  final int ayahNumber;
  final String ayahText;
  final String tafsirTitle;
  final TextStyle? titleLargeStyle;
  final TextStyle? titleMediumStyle;

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: 1080,
      height: 1400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _headerBadge(
            text:
                'سورة $surahName - الآية ${TafsirShareService._convertToArabicNumbers(ayahNumber)}',
            gradient: const [Color(0xFF4A90E2), Color(0xFF357ABD)],
            shadowColor: const Color(0xFF4A90E2),
            fontSize: 22,
          ),
          const SizedBox(height: 24),
          _headerBadge(
            text: tafsirTitle,
            gradient: const [Color(0xFF27AE60), Color(0xFF229954)],
            shadowColor: const Color(0xFF27AE60),
            fontSize: 18,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  style: titleLargeStyle?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    ayahText,
                    style: titleMediumStyle?.copyWith(
                      color: Colors.black,
                      height: 2.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _headerBadge({
    required String text,
    required List<Color> gradient,
    required Color shadowColor,
    required double fontSize,
  }) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradient),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: shadowColor.withAlpha(76),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

/// A single tafsir content page with footer pagination.
class _TafsirContentPage extends StatelessWidget {
  const _TafsirContentPage({
    required this.tafsirPart,
    required this.partIndex,
    required this.totalParts,
    required this.isArabic,
  });

  final String tafsirPart;
  final int partIndex;
  final int totalParts;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      width: 1080,
      height: 1400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tafsirPart,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
                textAlign: isArabic ? TextAlign.justify : TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _footer(),
        ],
      ),
    ),
  );

  Widget _footer() {
    final pageLabel = isArabic
        ? 'صفحة ${TafsirShareService._convertToArabicNumbers(partIndex + 1)} من ${TafsirShareService._convertToArabicNumbers(totalParts)}'
        : 'Page ${partIndex + 1} of $totalParts';
    final appLabel = isArabic ? 'تطبيق أسجد و أقترب' : 'Esjod & Approach App';

    return Column(
      children: [
        Divider(color: Colors.grey[400], height: 1, thickness: 1),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                pageLabel,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              appLabel,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
