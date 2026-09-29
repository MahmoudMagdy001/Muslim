import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/quran/view/quran_view.dart';
import 'package:muslim/features/settings/view_model/rectire/rectire_cubit.dart';
import 'package:quran/quran.dart' as quran;

class _SurahModel {
  const _SurahModel({
    required this.number,
    required this.nameArabic,
    required this.englishName,
    required this.verseCount,
    required this.revelationType,
    required this.startPage,
  });

  final int number;
  final String nameArabic;
  final String englishName;
  final int verseCount;
  final String revelationType;
  final int startPage;
}

class DailyVerseCard extends StatefulWidget {
  const DailyVerseCard({super.key});

  @override
  State<DailyVerseCard> createState() => _DailyVerseCardState();
}

class _DailyVerseCardState extends State<DailyVerseCard> {
  late _SurahModel _surah;
  late int _ayahNumber;
  late String _ayahText;

  @override
  void initState() {
    super.initState();
    _generateDailyVerse();
  }

  void _generateDailyVerse() {
    final now = DateTime.now();
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);

    final surahNum = random.nextInt(114) + 1;
    final verseCount = quran.getVerseCount(surahNum);
    final ayahNum = random.nextInt(verseCount) + 1;

    _ayahNumber = ayahNum;
    _ayahText = quran.getVerse(surahNum, ayahNum);

    _surah = _SurahModel(
      number: surahNum,
      nameArabic: quran.getSurahNameArabic(surahNum),
      englishName: quran.getSurahName(surahNum),
      verseCount: verseCount,
      revelationType: quran.getPlaceOfRevelation(surahNum),
      startPage: quran.getPageNumber(surahNum, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ayahStr = convertToArabicNumbers(_ayahNumber.toString());
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: context.radius.xlBorder,
        color: colors.primary,
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final reciter = context.read<ReciterCubit>().state.selectedReciter;
            unawaited(
              navigateWithTransition<void>(
                context,
                QuranView(
                  surahNumber: _surah.number,
                  reciter: reciter,
                  currentAyah: _ayahNumber,
                ),
                type: TransitionType.fade,
              ),
            );
          },
          borderRadius: context.radius.xlBorder,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: BoxDecoration(
                            color: colors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          isArabic ? 'آية اليوم وتدبر' : 'Verse of the Day',
                          style: context.typography.titleMedium.copyWith(
                            color: colors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'سورة ${_surah.nameArabic} - آية $ayahStr',
                        style: context.typography.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Text(
                  _ayahText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    fontSize: 20.sp,
                    color: Colors.white,
                    height: 1.8,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isArabic ? 'فتح السورة' : 'Read Surah',
                      style: context.typography.caption.copyWith(
                        color: colors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.r,
                      color: colors.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
