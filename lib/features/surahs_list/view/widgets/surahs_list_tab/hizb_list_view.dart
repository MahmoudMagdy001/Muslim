import 'package:flutter/material.dart';

import 'package:muslim/core/utils/responsive_helper.dart';
import 'package:muslim/features/surahs_list/model/hizb_model.dart';
import 'package:muslim/features/surahs_list/view/widgets/surahs_list_tab/hizb_list_tile.dart';

class HizbListView extends StatelessWidget {
  const HizbListView({
    required this.hizbs,
    required this.navigateToHizb,
    super.key,
  });

  final List<HizbModel> hizbs;
  final Future<void> Function({required int surah, required int ayah})
  navigateToHizb;

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
        final hizb = hizbs[index];
        return HizbListTile(
          hizb: hizb,
          onTap: () =>
              navigateToHizb(surah: hizb.startSurah, ayah: hizb.startAyah),
        );
      }, childCount: hizbs.length),
    ),
  );
}
