import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played.dart';
import 'package:muslim/features/quran/viewmodel/last_played_cubit/last_played_state.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/last_played_card.dart';

class LastPlayedSection extends StatelessWidget {
  const LastPlayedSection({required this.navigateToSurah, super.key});

  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsetsDirectional.only(
        start: 6.toW,
        end: 18.toW,
        top: 12.toH,
      ),
      child:
          BlocSelector<LastPlayedCubit, LastPlayedState, Map<String, dynamic>?>(
            selector: (state) => state.lastPlayed,
            builder: (context, lastPlayed) {
              if (lastPlayed == null) return const SizedBox.shrink();
              return LastPlayedCard(
                lastPlayed: lastPlayed,
                navigateToSurah: navigateToSurah,
              );
            },
          ),
    ),
  );
}
