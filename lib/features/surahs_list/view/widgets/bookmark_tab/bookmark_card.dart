import 'package:flutter/material.dart';

import 'package:quran/quran.dart' as quran;

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';
import '../../../../../core/utils/responsive_helper.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../quran/model/bookmark_model.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    required this.bookmark,
    required this.isArabic,
    required this.localizations,
    required this.reciter,
    required this.onOpen,
    required this.onDelete,
    super.key,
  });

  final AyahBookmark bookmark;
  final bool isArabic;
  final AppLocalizations localizations;
  final String reciter;
  final VoidCallback onOpen;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final surahName = isArabic
        ? quran.getSurahNameArabic(bookmark.surahNumber)
        : quran.getSurahName(bookmark.surahNumber);

    final ayahText = isArabic
        ? quran.getVerse(
            bookmark.surahNumber,
            bookmark.ayahNumber,
            verseEndSymbol: true,
          )
        : quran.getVerseTranslation(bookmark.surahNumber, bookmark.ayahNumber);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.toH, horizontal: 8.toW),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.cardGradient(context),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.toR),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(15.toR),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 12.toH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/quran/marker.png',
                        width: 40.toW,
                        height: 40.toH,
                      ),
                      Text(
                        isArabic
                            ? convertToArabicNumbers(
                                bookmark.surahNumber.toString(),
                              )
                            : bookmark.surahNumber.toString(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.toW),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surahName,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.toH),
                        Text(
                          isArabic
                              ? 'الآية ${convertToArabicNumbers(bookmark.ayahNumber.toString())}'
                              : 'Ayah ${bookmark.ayahNumber}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimary.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.toH),
              Text(
                ayahText,
                style: context.textTheme.displayMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
