import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/format_helper.dart';

class MushafPageContent extends StatelessWidget {
  const MushafPageContent({
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
  final void Function(int surah, int ayah, String text, Offset position)
  onAyahTap;

  @override
  Widget build(BuildContext context) {
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
            '${isArabic ? 'صفحة' : 'Page'} ${convertToArabicNumbers(pageNumber.toString())}',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const Divider(),
          ValueListenableBuilder<int?>(
            valueListenable: currentAyahNotifier,
            builder: (context, currentAyah, _) => ValueListenableBuilder<int?>(
              valueListenable: currentSurahNotifier,
              builder: (context, currentSurah, _) => RepaintBoundary(
                child: RichText(
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
                          arabicNumeral: isArabic,
                        );

                        final keyString = '${surah}_$ayah';
                        final key = ayahKeys.putIfAbsent(
                          keyString,
                          () => GlobalKey(),
                        );

                        spans
                          ..add(
                            WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              child: SizedBox(key: key, width: 0, height: 0),
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
                                  onAyahTap(
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
          ),
        ],
      ),
    );
  }
}
