import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/quran/service/quran_service.dart';
import 'package:muslim/features/quran/view/quran_view.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:muslim/features/quran/viewmodel/bookmarks_cubit/bookmarks_state.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:quran/quran.dart' as quran;

class ContinueReadingCard extends StatelessWidget {
  const ContinueReadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final reciter = context.watch<ReciterCubit>().state.selectedReciter;

    return BlocBuilder<BookmarksCubit, BookmarksState>(
      builder: (context, bookmarkState) {
        var surahNumber = 1;
        var ayahNumber = 1;

        if (bookmarkState.bookmarks.isNotEmpty) {
          final latest = bookmarkState.bookmarks.first;
          surahNumber = latest.surahNumber;
          ayahNumber = latest.ayahNumber;
        } else {
          final currentSurah = getIt<QuranService>().currentSurah;
          if (currentSurah != null && currentSurah > 0) {
            surahNumber = currentSurah;
          }
        }

        final surahName = isArabic
            ? quran.getSurahNameArabic(surahNumber)
            : quran.getSurahName(surahNumber);
        final totalVerses = quran.getVerseCount(surahNumber);
        final juz = quran.getJuzNumber(surahNumber, ayahNumber);

        final ayahText = isArabic
            ? 'آية ${convertToArabicNumbers(ayahNumber.toString())} من ${convertToArabicNumbers(totalVerses.toString())}'
            : 'Verse $ayahNumber of $totalVerses';
        final juzText = isArabic
            ? 'الجزء ${convertToArabicNumbers(juz.toString())}'
            : 'Juz $juz';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.toW, vertical: 6.toH),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.toR),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: context.cardGradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  unawaited(
                    navigateWithTransition<void>(
                      context,
                      QuranView(
                        surahNumber: surahNumber,
                        reciter: reciter,
                        currentAyah: ayahNumber,
                      ),
                      type: TransitionType.fade,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20.toR),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.toW, vertical: 14.toH),
                  child: Row(
                    children: [
                      // Quran Artwork Thumbnail
                      Container(
                        width: 58.toW,
                        height: 58.toH,
                        padding: EdgeInsets.all(8.toR),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16.toR),
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Image.asset(
                          'assets/home/quran.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.menu_book, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 14.toW),

                      // Text Metadata
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  isArabic ? 'متابعة الورد القرآني' : 'Continue Reading',
                                  style: context.textTheme.labelMedium?.copyWith(
                                    color: const Color(0xFFE5C467),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.toW,
                                    vertical: 2.toH,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10.toR),
                                  ),
                                  child: Text(
                                    juzText,
                                    style: context.textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.toH),
                            Text(
                              isArabic ? 'سورة $surahName' : 'Surah $surahName',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.toH),
                            Text(
                              ayahText,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10.toW),

                      // Action Button Icon
                      Container(
                        padding: EdgeInsets.all(10.toR),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Color(0xFF1A3B34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
