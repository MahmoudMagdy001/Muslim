import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_bloc.dart';
import 'package:muslim/features/quran/presentation/bloc/last_played/last_played_state.dart';
import 'package:muslim/features/quran/presentation/views/quran_view.dart';
import 'package:muslim/features/settings/presentation/bloc/reciter/reciter_bloc.dart';
import 'package:muslim/features/surahs_list/presentation/views/widgets/surahs_list_tab/last_played_card.dart';
import 'package:quran/quran.dart' as quran;

/// Hero card on the Home screen displaying the last read Quran position,
/// synchronized with the Quran tab.
class ContinueReadingCard extends StatelessWidget {
  const ContinueReadingCard({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<LastPlayedBloc, LastPlayedState, Map<String, dynamic>?>(
        selector: (state) => state.lastPlayed,
        builder: (context, lastPlayed) {
          final reciter = context.watch<ReciterBloc>().state.selectedReciter;

          final effectiveLastPlayed = lastPlayed ?? {
            'surah': 1,
            'verse': 1,
            'reciter': reciter,
          };

          return LastPlayedCard(
            lastPlayed: effectiveLastPlayed,
            navigateToSurah: ({required surah, required ayah}) async {
              final startPage = quran.getPageNumber(surah, 1);
              final endPage = quran.getPageNumber(
                surah,
                quran.getVerseCount(surah),
              );

              await navigateWithTransition<void>(
                context,
                QuranView(
                  surahNumber: surah,
                  reciter: reciter,
                  currentAyah: ayah,
                  fromPage: startPage,
                  toPage: endPage,
                ),
                type: TransitionType.fade,
              );

              if (context.mounted) {
                await context.read<LastPlayedBloc>().initialize();
              }
            },
          );
        },
      );
}
