import 'package:flutter/material.dart';

import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/juz_model.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/juz_list_tile.dart';

class JuzListView extends StatelessWidget {
  const JuzListView({
    required this.juzs,
    required this.navigateToJuz,
    super.key,
  });

  final List<JuzModel> juzs;
  final Future<void> Function({required int surah, required int ayah})
  navigateToJuz;

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
        final juz = juzs[index];
        return JuzListTile(
          juz: juz,
          onTap: () =>
              navigateToJuz(surah: juz.startSurah, ayah: juz.startAyah),
        );
      }, childCount: juzs.length),
    ),
  );
}
