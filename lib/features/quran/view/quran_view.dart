import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;

import '../../../core/service/last_read_service.dart';
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
        create: (context) => QuranPlayerCubit(QuranRepositoryImpl()),
      ),
      BlocProvider(
        create: (context) =>
            QuranSurahCubit(QuranRepositoryImpl())
              ..loadSurah(surahNumber, reciter),
      ),
    ],
    child: QuranViewContent(surahNumber: surahNumber, reciter: reciter),
  );
}

class QuranViewContent extends StatelessWidget {
  const QuranViewContent({
    required this.surahNumber,
    required this.reciter,
    super.key,
  });

  final int surahNumber;
  final String reciter;

  @override
  Widget build(BuildContext context) {
    final surahName = quran.getSurahNameArabic(surahNumber);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('سورة $surahName')),
        body: MultiBlocListener(
          listeners: [
            BlocListener<QuranPlayerCubit, QuranPlayerState>(
              listener: (context, state) {
                try {
                  LastReadService().saveLastRead(
                    surah: surahNumber,
                    ayah: state.currentAyah,
                  );
                } catch (e) {
                  debugPrint('Error saving last read: $e');
                }
              },
            ),
          ],

          child: BlocBuilder<QuranSurahCubit, QuranSurahState>(
            builder: (context, state) {
              switch (state.status) {
                case QuranSurahStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case QuranSurahStatus.error:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('حدث خطأ: ${state.message}'),
                        ElevatedButton(
                          onPressed: () {
                            context.read<QuranSurahCubit>().resumeLastRead(
                              reciter,
                            );
                          },
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                case QuranSurahStatus.loaded:
                case QuranSurahStatus.alreadyLoaded:
                  final actualSurahNumber = state.surahNumber ?? surahNumber;
                  return Column(
                    children: [
                      Expanded(
                        child: SurahTextView(surahNumber: actualSurahNumber),
                      ),
                      const PlayerControlsWidget(),
                    ],
                  );
                case QuranSurahStatus.initial:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
