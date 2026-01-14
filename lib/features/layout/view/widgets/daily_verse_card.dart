import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

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
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1), // Light teal background
        borderRadius: BorderRadius.circular(16.toR),
        border: Border.all(color: context.colorScheme.primary.withAlpha(50)),
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
        borderRadius: BorderRadius.circular(16.toR),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ورد اليوم',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'سورة ${_surah.nameArabic}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.primary.withAlpha(200),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.toH),
              Container(
                padding: EdgeInsets.all(16.toR),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.toR),
                ),
                child: Column(
                  children: [
                    Text(
                      _ayahText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.amiri(
                        fontSize: 20.sp,
                        color: Colors.black87,
                        height: 1.6,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 12.toH),
                    Text(
                      'سورة ${_surah.nameArabic} - الجزء ${quran.getJuzNumber(_surah.number, _ayahNumber)} - آية $ayahStr',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.toH),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final reciter = context
                        .read<ReciterCubit>()
                        .state
                        .selectedReciter;
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF589C94),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('اقرأ المزيد'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
