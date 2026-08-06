import 'package:flutter/material.dart';

import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/surahs_list_model.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tile.dart';

class SurahList extends StatelessWidget {
  const SurahList({
    required this.surahs,
    required this.navigateToSurah,
    super.key,
  });

  final List<SurahsListModel> surahs;
  final Future<void> Function({required int surah, required int ayah})
  navigateToSurah;

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: EdgeInsetsDirectional.only(
      start: 6.toW,
      end: 20.toW,
      top: 8.toH,
      bottom: 8.toH,
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final surah = surahs[index];
        return SurahListTile(
          surah: surah,
          onTap: () => navigateToSurah(surah: surah.number, ayah: 1),
        );
      }, childCount: surahs.length),
    ),
  );
}
