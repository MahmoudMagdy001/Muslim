import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:quran/quran.dart' as quran;

// ponytail: converted to StatefulWidget to cache and dispose TapGestureRecognizer instances, avoiding native leaks
class SurahTextContent extends StatefulWidget {
  const SurahTextContent({
    required this.surahNumber,
    required this.isArabic,
    required this.currentAyahNotifier,
    required this.ayahKeys,
    required this.onAyahTap,
    super.key,
  });

  final int surahNumber;
  final bool isArabic;
  final ValueNotifier<int?> currentAyahNotifier;
  final Map<int, GlobalKey> ayahKeys;
  final void Function(int ayah, String text, Offset position) onAyahTap;

  @override
  State<SurahTextContent> createState() => _SurahTextContentState();
}

class _SurahTextContentState extends State<SurahTextContent> {
  final Map<int, TapGestureRecognizer> _recognizers = {};

  @override
  void dispose() {
    for (final recognizer in _recognizers.values) {
      recognizer.dispose();
    }
    super.dispose();
  }

  TapGestureRecognizer _getOrCreateRecognizer(int ayah, String text) =>
      _recognizers.putIfAbsent(
        ayah,
        () => TapGestureRecognizer()
          ..onTapDown = (details) {
            widget.onAyahTap(ayah, text, details.globalPosition);
          },
      );

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int?>(
    valueListenable: widget.currentAyahNotifier,
    builder: (context, currentAyah, child) => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.titleLarge?.copyWith(
          height: widget.isArabic ? 2.3 : 1.7,
          fontWeight: FontWeight.normal,
        ),
        children: _buildSpans(context, currentAyah),
      ),
    ),
  );

  List<InlineSpan> _buildSpans(BuildContext context, int? currentAyah) {
    final ayahCount = quran.getVerseCount(widget.surahNumber);
    final spans = <InlineSpan>[];

    for (var ayah = 1; ayah <= ayahCount; ayah++) {
      final endSymbol = quran.getVerseEndSymbol(ayah, arabicNumeral: widget.isArabic);
      final text = widget.isArabic
          ? quran.getVerse(widget.surahNumber, ayah)
          : quran.getVerseTranslation(widget.surahNumber, ayah);

      final isCurrent = ayah == currentAyah;
      final keyForThisAyah = widget.ayahKeys.putIfAbsent(ayah, GlobalKey.new);

      spans.add(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: SizedBox.shrink(key: keyForThisAyah),
            ),
            TextSpan(
              text: '$text ',
              style: context.textTheme.displayMedium?.copyWith(
                color: isCurrent
                    ? context.colorScheme.error
                    : context.textTheme.bodyLarge?.color,
              ),
              recognizer: _getOrCreateRecognizer(ayah, text),
            ),
            TextSpan(text: endSymbol, style: context.textTheme.displayMedium),
            const TextSpan(text: ' '),
          ],
        ),
      );
    }
    return spans;
  }
}
