import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';

class MushafText extends StatelessWidget {
  const MushafText({
    required this.ayahOrder,
    required this.recognizers,
    required this.verseTexts,
    required this.endSymbols,
    required this.ayahStartKeys,
    required this.ayahEndKeys,
    required this.currentAyahNotifier,
    required this.currentSurahNotifier,
    required this.settings,
    super.key,
  });

  final List<(int, int)> ayahOrder;
  final Map<String, TapGestureRecognizer> recognizers;
  final Map<String, String> verseTexts;
  final Map<String, String> endSymbols;
  final Map<String, GlobalKey> ayahStartKeys;
  final Map<String, GlobalKey> ayahEndKeys;
  final ValueNotifier<int?> currentAyahNotifier;
  final ValueNotifier<int?> currentSurahNotifier;
  final QuranReaderSettings settings;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int?>(
        valueListenable: currentAyahNotifier,
        builder: (context, currentAyah, _) => ValueListenableBuilder<int?>(
          valueListenable: currentSurahNotifier,
          builder: (context, currentSurah, _) => RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.amiri().copyWith(
                fontSize: settings.fontSize.toSp,
                height: 2.2,
                color: settings.theme.textColor,
              ),
              children: _buildSpans(context, currentSurah, currentAyah),
            ),
          ),
        ),
      );

  List<InlineSpan> _buildSpans(
    BuildContext context,
    int? currentSurah,
    int? currentAyah,
  ) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final suffix = isArabic ? '_ar' : '_en';
    final theme = settings.theme;
    final spans = <InlineSpan>[];

    for (final (surah, ayah) in ayahOrder) {
      final isCurrent = ayah == currentAyah && surah == currentSurah;
      final k = '${surah}_$ayah';
      final startKey = ayahStartKeys.putIfAbsent(k, GlobalKey.new);
      final endKey = ayahEndKeys.putIfAbsent(k, GlobalKey.new);

      spans
        ..add(
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: SizedBox.shrink(key: startKey),
          ),
        )
        ..add(
          TextSpan(
            text: '${verseTexts[k] ?? ''} ',
            style: TextStyle(
              color: isCurrent ? theme.activeAyahTextColor : theme.textColor,
              backgroundColor: isCurrent ? theme.activeAyahHighlight : null,
            ),
            recognizer: recognizers[k],
          ),
        )
        ..add(
          TextSpan(
            text: '${endSymbols['$k$suffix'] ?? ''} ',
            style: TextStyle(
              color: isCurrent ? theme.activeAyahTextColor : theme.frameColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
        ..add(
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: SizedBox.shrink(key: endKey),
          ),
        );
    }
    return spans;
  }
}
