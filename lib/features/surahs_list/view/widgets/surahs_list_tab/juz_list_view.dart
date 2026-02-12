import 'package:flutter/material.dart';

import '../../../../../core/utils/responsive_helper.dart';
import '../../../model/juz_model.dart';
import 'juz_list_tile.dart';

class JuzListView extends StatelessWidget {
  const JuzListView({
    required this.juzs,
    required this.isArabic,
    required this.navigateToJuz,
    super.key,
  });

  final List<JuzModel> juzs;
  final bool isArabic;
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
          isArabic: isArabic,
          onTap: () =>
              navigateToJuz(surah: juz.startSurah, ayah: juz.startAyah),
        );
      }, childCount: juzs.length),
    ),
  );
}
