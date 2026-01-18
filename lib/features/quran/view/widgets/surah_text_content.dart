import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/utils/extensions.dart';

class SurahTextContent extends StatelessWidget {
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
  final Function(int ayah, String text, Offset position) onAyahTap;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int?>(
    valueListenable: currentAyahNotifier,
    builder: (context, currentAyah, child) => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.titleLarge?.copyWith(
          height: isArabic ? 2.3 : 1.7,
          fontWeight: FontWeight.normal,
        ),
        children: _buildSpans(context, currentAyah),
      ),
    ),
  );

  List<InlineSpan> _buildSpans(BuildContext context, int? currentAyah) {
    final ayahCount = quran.getVerseCount(surahNumber);
    final spans = <InlineSpan>[];

    for (int ayah = 1; ayah <= ayahCount; ayah++) {
      final endSymbol = quran.getVerseEndSymbol(ayah, arabicNumeral: isArabic);
      final text = isArabic
          ? quran.getVerse(surahNumber, ayah)
          : quran.getVerseTranslation(surahNumber, ayah);

      final isCurrent = ayah == currentAyah;
      final keyForThisAyah = ayahKeys.putIfAbsent(ayah, () => GlobalKey());

      spans.add(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: SizedBox(key: keyForThisAyah, width: 0, height: 0),
            ),
            TextSpan(
              text: '$text ',
              style: context.textTheme.displayMedium?.copyWith(
                color: isCurrent
                    ? context.colorScheme.error
                    : context.textTheme.bodyLarge?.color,
              ),
              recognizer: TapGestureRecognizer()
                ..onTapDown = (details) {
                  onAyahTap(ayah, text, details.globalPosition);
                }
                ..onTap = () {
                  // Handled in onTapDown to get position
                },
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
