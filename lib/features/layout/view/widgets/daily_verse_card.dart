import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_helper.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../quran/view/quran_view.dart';
import '../../../settings/view_model/rectire/rectire_cubit.dart';

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
    // A deterministic seed per day
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);

    // Pick a random Surah (1 to 114)
    final surahNum = random.nextInt(114) + 1;
    final verseCount = quran.getVerseCount(surahNum);
    // Pick a random Ayah (1 to verseCount)
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.toR),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: AppColors.cardGradient(context),
        ),
      ),
      child: InkWell(
        onTap: () {
          final reciter = context.read<ReciterCubit>().state.selectedReciter;
          navigateWithTransition(
            context,
            QuranView(
              surahNumber: _surah.number,
              reciter: reciter,
              currentAyah: _ayahNumber,
            ),
            type: TransitionType.fade,
          );
        },
        borderRadius: BorderRadius.circular(24.toR),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ورد اليوم',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.toH),
                    Text(
                      'سورة ${_surah.nameArabic} - آية $ayahStr',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 12.toH),
                    Text(
                      _ayahText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.amiri(
                        fontSize: 18.sp,
                        color: Colors.white,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 16.toH),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.toW,
                        vertical: 8.toH,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20.toR),
                      ),
                      child: Text(
                        'اقرأ المزيد',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.toW),
              Image.asset(
                'assets/home/quran.png',
                height: 80.toH,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.menu_book,
                  size: 60,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
