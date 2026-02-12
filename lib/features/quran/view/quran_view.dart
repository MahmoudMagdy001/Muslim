import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:quran/quran.dart' as quran;

import '../../../core/utils/extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../repository/quran_repository.dart';
import '../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import 'utils/quran_position_helper.dart';
import 'widgets/mushaf_view.dart';
import 'widgets/player_controls_widget.dart';

class QuranView extends StatelessWidget {
  const QuranView({
    required this.surahNumber,
    required this.reciter,
    required this.currentAyah,
    this.fromPage,
    this.toPage,
    super.key,
  });

  final int surahNumber;
  final int currentAyah;
  final String reciter;
  final int? fromPage;
  final int? toPage;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => QuranPlayerCubit(
      GetIt.instance<QuranRepository>(),
      initialSurah: surahNumber,
    ),
    child: QuranViewContent(
      surahNumber: surahNumber,
      reciter: reciter,
      startAyah: currentAyah,
      fromPage: fromPage,
      toPage: toPage,
    ),
  );
}

class QuranViewContent extends StatefulWidget {
  const QuranViewContent({
    required this.surahNumber,
    required this.reciter,
    this.startAyah = 1,
    this.fromPage,
    this.toPage,
    super.key,
  });

  final int surahNumber;
  final String reciter;
  final int startAyah;
  final int? fromPage;
  final int? toPage;

  @override
  State<QuranViewContent> createState() => _QuranViewContentState();
}

class _QuranViewContentState extends State<QuranViewContent> {
  late int _currentSurahNumber;
  int? _currentJuz;
  int? _currentHizb;

  @override
  void initState() {
    super.initState();
    _currentSurahNumber = widget.surahNumber;

    // Initialize Juz/Hizb based on startAyah
    _currentJuz = getJuzForAyah(widget.surahNumber, widget.startAyah);
    _currentHizb = getHizbForAyah(widget.surahNumber, widget.startAyah);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranPlayerCubit>().loadSurah(
        widget.surahNumber,
        widget.reciter,
        startAyah: widget.startAyah,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);

    final surahName = isArabic
        ? quran.getSurahNameArabic(_currentSurahNumber)
        : quran.getSurahName(_currentSurahNumber);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              surahName,
              style: context.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_currentJuz != null && _currentHizb != null)
              Container(
                margin: EdgeInsets.only(top: 2.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${isArabic ? 'الجزء' : 'Juz'} $_currentJuz • ${isArabic ? 'الحزب' : 'Hizb'} $_currentHizb',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MushafView(
                surahNumber: widget.surahNumber,
                initialPage: quran.getPageNumber(
                  widget.surahNumber,
                  widget.startAyah,
                ),
                isArabic: isArabic,
                localizations: localizations,
                fromPage: widget.fromPage,
                toPage: widget.toPage,
                onPartChanged: (newSurah, newJuz, newHizb) {
                  if (_currentSurahNumber != newSurah ||
                      _currentJuz != newJuz ||
                      _currentHizb != newHizb) {
                    setState(() {
                      _currentSurahNumber = newSurah;
                      _currentJuz = newJuz;
                      _currentHizb = newHizb;
                    });
                  }
                },
              ),
            ),
            const PlayerControlsWidget(),
          ],
        ),
      ),
    );
  }
}
