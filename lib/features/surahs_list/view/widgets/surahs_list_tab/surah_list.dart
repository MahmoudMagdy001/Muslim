import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_helper.dart';
import '../../../model/surahs_list_model.dart';
import '../surahs_list_tile.dart';

class SurahList extends StatelessWidget {
  const SurahList({
    required this.surahs,
    required this.isArabic,
    required this.navigateToSurah,
    super.key,
  });

  final List<SurahsListModel> surahs;
  final bool isArabic;
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
          isArabic: isArabic,
          onTap: () => navigateToSurah(surah: surah.number, ayah: 1),
        );
      }, childCount: surahs.length),
    ),
  );
}
