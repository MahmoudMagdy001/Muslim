import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../model/hadith_model.dart';
import '../../../../view_model/hadith/hadith_cubit.dart';
import 'hadith_card.dart';
import 'hadith_empty.dart';

class HadithsList extends StatelessWidget {
  const HadithsList({
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.hadiths,
    required this.isArabic,
    required this.localizations,
    required this.cubit,
    required this.onShowSnackBar,
    super.key,
  });

  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final List<HadithModel> hadiths;
  final bool isArabic;
  final AppLocalizations localizations;
  final HadithCubit cubit;
  final Function(String) onShowSnackBar;

  @override
  Widget build(BuildContext context) {
    if (hadiths.isEmpty) {
      return EmptyHadithsState(localizations: localizations);
    }

    return SafeArea(
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        padding: const EdgeInsetsDirectional.only(
          start: 5,
          end: 5,
          top: 8,
          bottom: 8,
        ).resolve(Directionality.of(context)),
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadith = hadiths[index];
          return HadithCard(
            hadith: hadith,
            isArabic: isArabic,
            localizations: localizations,
            cubit: cubit,
            onShowSnackBar: onShowSnackBar,
          );
        },
      ),
    );
  }
}
