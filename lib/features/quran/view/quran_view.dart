import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/app_localizations.dart';
import '../repository/quran_repository_impl.dart';
import '../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../viewmodel/quran_surah_cubit/quran_surah_cubit.dart';
import '../viewmodel/quran_surah_cubit/quran_surah_state.dart';
import 'widgets/player_controls_widget.dart';
import 'widgets/surah_text_view.dart';
import 'widgets/mushaf_view.dart';

class QuranView extends StatelessWidget {
  const QuranView({
    required this.surahNumber,
    required this.reciter,
    required this.currentAyah,
    super.key,
  });

  final int surahNumber;
  final int currentAyah;
  final String reciter;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            QuranPlayerCubit(QuranRepositoryImpl(), initialSurah: surahNumber),
      ),
      BlocProvider(
        create: (context) =>
            QuranSurahCubit(QuranRepositoryImpl())
              ..loadSurah(surahNumber, reciter, startAyah: currentAyah),
      ),
    ],
    child: QuranViewContent(
      surahNumber: surahNumber,
      reciter: reciter,
      startAyah: currentAyah,
    ),
  );
}

class QuranViewContent extends StatefulWidget {
  const QuranViewContent({
    required this.surahNumber,
    required this.reciter,
    this.startAyah = 1,
    super.key,
  });

  final int surahNumber;
  final String reciter;
  final int startAyah;

  @override
  State<QuranViewContent> createState() => _QuranViewContentState();
}

class _QuranViewContentState extends State<QuranViewContent> {
  bool _sought = false;
  final ValueNotifier<bool> mushafModeNotifier = ValueNotifier(false);
  static const String _mushafModeKey = 'is_mushaf_mode';

  @override
  void initState() {
    super.initState();
    _loadViewMode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeSeekToStartAyah(context);
    });
  }

  @override
  void dispose() {
    mushafModeNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadViewMode() async {
    final prefs = await SharedPreferences.getInstance();
    mushafModeNotifier.value = prefs.getBool(_mushafModeKey) ?? false;
  }

  Future<void> _toggleViewMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !mushafModeNotifier.value;
    mushafModeNotifier.value = newValue;
    prefs.setBool(_mushafModeKey, newValue);
  }

  void _maybeSeekToStartAyah(BuildContext context) {
    if (_sought || widget.startAyah <= 1) return;
    _sought = true;
    context.read<QuranPlayerCubit>().seek(
      Duration.zero,
      index: widget.startAyah - 1,
      surah: widget.surahNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);

    final surahName = isArabic
        ? quran.getSurahNameArabic(widget.surahNumber)
        : quran.getSurahName(widget.surahNumber);

    return ValueListenableBuilder<bool>(
      valueListenable: mushafModeNotifier,
      builder: (context, isMushafMode, child) => Scaffold(
        appBar: AppBar(
          title: Text(surahName),
          actions: [
            IconButton(
              icon: Icon(isMushafMode ? Icons.list_alt : Icons.menu_book),
              onPressed: _toggleViewMode,
              tooltip: isMushafMode ? 'عرض السور' : 'عرض المصحف',
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: isMushafMode
                    ? MushafView(
                        surahNumber: widget.surahNumber,
                        initialPage: quran.getPageNumber(
                          widget.surahNumber,
                          widget.startAyah,
                        ),
                        isArabic: isArabic,
                        localizations: localizations,
                      )
                    : BlocSelector<QuranSurahCubit, QuranSurahState, int?>(
                        selector: (state) => state.surahNumber,
                        builder: (context, surahNumber) {
                          final actualSurahNumber =
                              surahNumber ?? widget.surahNumber;
                          return SurahTextView(
                            surahNumber: actualSurahNumber,
                            startAyah: widget.startAyah,
                            isArabic: isArabic,
                            localizations: localizations,
                          );
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
