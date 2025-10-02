import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../repository/quran_repository_impl.dart';

import '../viewmodel/quran_player_cubit/quran_player_cubit.dart';
import '../viewmodel/quran_player_cubit/quran_player_state.dart';
import '../viewmodel/quran_surah_cubit/quran_surah_cubit.dart';
import '../viewmodel/quran_surah_cubit/quran_surah_state.dart';
import 'widgets/player_controls_widget.dart';
import 'widgets/surah_text_view.dart';

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

  void _maybeSeekToStartAyah(BuildContext context) {
    if (_sought) return;
    if (widget.startAyah <= 1) return;
    _sought = true;
    context.read<QuranPlayerCubit>().seek(
      Duration.zero,
      index: widget.startAyah - 1,
      surah: widget.surahNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    final surahName = quran.getSurahNameArabic(widget.surahNumber);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('سورة $surahName')),
        body: BlocBuilder<QuranSurahCubit, QuranSurahState>(
          builder: (context, state) {
            if (state.status == QuranSurahStatus.loaded) {
              final actualSurahNumber = state.surahNumber ?? widget.surahNumber;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _maybeSeekToStartAyah(context);
              });
              return Column(
                children: [
                  Expanded(
                    child: SurahTextView(
                      key: ValueKey<int>(actualSurahNumber),
                      surahNumber: actualSurahNumber,
                    ),
                  ),
                  BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
                    builder: (context, playerState) =>
                        const PlayerControlsWidget(),
                  ),
                ],
              );
            } else {
              final actualSurahNumber = state.surahNumber ?? widget.surahNumber;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _maybeSeekToStartAyah(context);
              });
              return Column(
                children: [
                  Expanded(
                    child: SurahTextView(
                      key: ValueKey<int>(actualSurahNumber),
                      surahNumber: actualSurahNumber,
                    ),
                  ),
                  BlocBuilder<QuranPlayerCubit, QuranPlayerState>(
                    builder: (context, playerState) =>
                        const PlayerControlsWidget(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
