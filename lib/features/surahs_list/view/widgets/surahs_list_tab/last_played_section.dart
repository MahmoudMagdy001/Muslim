import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/responsive_helper.dart';
import '../../../../quran/viewmodel/last_played_cubit/last_played.dart';
import 'last_played_card.dart';

class LastPlayedSection extends StatelessWidget {
  const LastPlayedSection({required this.navigateToSurah, super.key});

  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsetsDirectional.only(start: 6.toW, end: 18.toW),
      child:
          BlocSelector<
            LastPlayedCubit,
            Map<String, dynamic>?,
            Map<String, dynamic>?
          >(
            selector: (state) => state,
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
