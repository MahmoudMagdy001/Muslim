import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/quran/view/utils/quran_position_helper.dart';
import 'package:muslim/features/quran/view/widgets/mushaf_view.dart';
import 'package:muslim/features/quran/view/widgets/player_controls_widget.dart';
import 'package:muslim/features/quran/viewmodel/quran_player_cubit/quran_player_cubit.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:quran/quran.dart' as quran;

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
    create: (context) => getIt<QuranPlayerCubit>(),
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
  late final ValueNotifier<(int, int?, int?)> _headerNotifier;

  @override
  void initState() {
    super.initState();
    _headerNotifier = ValueNotifier((
      widget.surahNumber,
      getJuzForAyah(widget.surahNumber, widget.startAyah),
      getHizbForAyah(widget.surahNumber, widget.startAyah),
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromPage != null && widget.toPage != null) {
        unawaited(
          context.read<QuranPlayerCubit>().loadRange(
            fromPage: widget.fromPage!,
            toPage: widget.toPage!,
            reciter: widget.reciter,
            startSurah: widget.surahNumber,
            startAyah: widget.startAyah,
          ),
        );
      } else {
        unawaited(
          context.read<QuranPlayerCubit>().loadSurah(
            widget.surahNumber,
            widget.reciter,
            startAyah: widget.startAyah,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _headerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder<(int, int?, int?)>(
          valueListenable: _headerNotifier,
          builder: (context, header, _) {
            final (surahNum, juz, hizb) = header;
            final surahName = isArabic
                ? quran.getSurahNameArabic(surahNum)
                : quran.getSurahName(surahNum);
            return Column(
              children: [
                Text(
                  surahName,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (juz != null && hizb != null)
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${localizations.juzNumberLabel(juz)} • ${localizations.hizbNumberLabel(hizb)}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            );
          },
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
                localizations: localizations,
                fromPage: widget.fromPage,
                toPage: widget.toPage,
                onPartChanged: (newSurah, newJuz, newHizb) {
                  final current = _headerNotifier.value;
                  if (current.$1 != newSurah ||
                      current.$2 != newJuz ||
                      current.$3 != newHizb) {
                    _headerNotifier.value = (newSurah, newJuz, newHizb);
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
