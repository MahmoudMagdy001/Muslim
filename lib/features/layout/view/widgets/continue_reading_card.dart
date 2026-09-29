import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
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
    final colors = context.colors;

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
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: context.radius.lgBorder,
              border: Border.all(
                color: colors.border,
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
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
                borderRadius: context.radius.lgBorder,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Row(
                    children: [
                      // Quran Artwork Frame
                      Container(
                        width: 52.r,
                        height: 52.r,
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: colors.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: colors.secondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Image.asset(
                          'assets/home/quran.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.menu_book_rounded,
                            color: colors.secondary,
                            size: 24.r,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),

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
                                  style: context.typography.caption.copyWith(
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceVariant,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: colors.border,
                                      width: 0.6,
                                    ),
                                  ),
                                  child: Text(
                                    juzText,
                                    style: context.typography.caption.copyWith(
                                      color: colors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.5.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              isArabic ? 'سورة $surahName' : 'Surah $surahName',
                              style: context.typography.titleMedium.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              ayahText,
                              style: context.typography.bodySmall.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10.w),

                      // Action Button Icon
                      Container(
                        padding: EdgeInsets.all(9.r),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.r,
                          color: Colors.white,
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
