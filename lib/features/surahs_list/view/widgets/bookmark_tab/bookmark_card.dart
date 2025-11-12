import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 5,
        top: 5,
        start: 5,
        end: 15,
      ),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(surahName, style: theme.textTheme.titleLarge),
                    IconButton(
                      tooltip: localizations.deleteBookmark,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  ayahText,
                  style: theme.textTheme.titleMedium!.copyWith(
                    height: isArabic ? 2.1 : 1.5,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
