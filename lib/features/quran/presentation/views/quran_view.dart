import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim/core/di/service_locator.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/quran/presentation/bloc/quran_player/quran_player_bloc.dart';
import 'package:muslim/features/quran/presentation/models/quran_reader_settings.dart';
import 'package:muslim/features/quran/presentation/views/bookmarks_view.dart';
import 'package:muslim/features/quran/presentation/views/utils/quran_position_helper.dart';
import 'package:muslim/features/quran/presentation/views/widgets/mushaf_view.dart';
import 'package:muslim/features/quran/presentation/views/widgets/player_controls_widget.dart';
import 'package:muslim/features/quran/presentation/views/widgets/reader_settings_dialog.dart';
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
    create: (context) => getIt<QuranPlayerBloc>(),
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
  late final ValueNotifier<QuranReaderSettings> _readerSettingsNotifier;

  @override
  void initState() {
    super.initState();
    _headerNotifier = ValueNotifier((
      widget.surahNumber,
      getJuzForAyah(widget.surahNumber, widget.startAyah),
      getHizbForAyah(widget.surahNumber, widget.startAyah),
    ));

    _readerSettingsNotifier = ValueNotifier(const QuranReaderSettings());
    unawaited(
      QuranReaderSettings.load().then((settings) {
        if (mounted) {
          _readerSettingsNotifier.value = settings;
        }
      }),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.fromPage != null && widget.toPage != null) {
        unawaited(
          context.read<QuranPlayerBloc>().loadRange(
            fromPage: widget.fromPage!,
            toPage: widget.toPage!,
            reciter: widget.reciter,
            startSurah: widget.surahNumber,
            startAyah: widget.startAyah,
          ),
        );
      } else {
        unawaited(
          context.read<QuranPlayerBloc>().loadSurah(
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
    _readerSettingsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final localizations = context.l10n;
    final colors = context.colors;

    return ValueListenableBuilder<QuranReaderSettings>(
      valueListenable: _readerSettingsNotifier,
      builder: (context, readerSettings, _) => Scaffold(
        backgroundColor: readerSettings.theme.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 70.h,
          centerTitle: true,
          backgroundColor: colors.isDark
              ? const Color(0xFF142722)
              : colors.primary,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: ValueListenableBuilder<(int, int?, int?)>(
            valueListenable: _headerNotifier,
            builder: (context, header, _) {
              final (surahNum, juz, hizb) = header;
              final surahName = isArabic
                  ? quran.getSurahNameArabic(surahNum)
                  : quran.getSurahName(surahNum);
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isArabic ? 'سُورَةُ $surahName' : 'Surah $surahName',
                    style: GoogleFonts.amiri(
                      color: const Color(0xFFFFE082),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  if (juz != null && hizb != null) ...[
                    SizedBox(height: 3.h),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.25),
                        borderRadius: context.radius.mdBorder,
                        border: Border.all(
                          color: const Color(0xFFC59F48).withValues(alpha: 0.35),
                          width: 0.6,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                        child: Text(
                          '${localizations.juzNumberLabel(juz)} • ${localizations.hizbNumberLabel(hizb)}',
                          style: GoogleFonts.cairo(
                            color: const Color(0xFFFAF7EE),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          actions: [
            // Reading appearance & font size settings
            IconButton(
              icon: const Icon(Icons.text_format_rounded, color: Colors.white),
              tooltip: isArabic ? 'مظهر القراءة والخط' : 'Reader Settings',
              onPressed: () => ReaderSettingsDialog.show(
                context,
                currentSettings: _readerSettingsNotifier.value,
                onChanged: (newSettings) {
                  _readerSettingsNotifier.value = newSettings;
                },
              ),
            ),
            // Bookmarks shortcut
            IconButton(
              icon: const Icon(Icons.bookmarks_outlined, color: Colors.white),
              tooltip: localizations.bookmarksText,
              onPressed: () => unawaited(
                navigateWithTransition<void>(
                  type: TransitionType.fade,
                  context,
                  BookmarksView(reciter: widget.reciter),
                ),
              ),
            ),
            SizedBox(width: 4.w),
          ],
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
                  readerSettingsNotifier: _readerSettingsNotifier,
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
      ),
    );
  }
}
