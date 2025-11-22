import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../model/hadith_model.dart';
import '../../../../view_model/hadith/hadith_cubit.dart';
import 'hadith_card.dart';
import 'hadith_empty.dart';

class HadithsList extends StatelessWidget {
  const HadithsList({
    required this.scrollController,
    required this.hadiths,
    required this.isArabic,
    required this.localizations,
    required this.cubit,
    required this.onShowSnackBar,
    super.key,
  });

  final ScrollController scrollController;
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
      child: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsetsDirectional.only(
            start: 5,
            end: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            children: hadiths
                .map(
                  (hadith) => HadithCard(
                    hadith: hadith,
                    isArabic: isArabic,
                    localizations: localizations,
                    cubit: cubit,
                    onShowSnackBar: onShowSnackBar,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
