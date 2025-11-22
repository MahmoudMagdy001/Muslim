import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/custom_loading_indicator.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../view_model/hadith/hadith_cubit.dart';
import '../../../../view_model/hadith/hadith_state.dart';
import 'hadith_error.dart';
import 'hadith_list.dart';

class HadithsBody extends StatelessWidget {
  const HadithsBody({
    required this.scrollController,
    required this.localizations,
    required this.isArabic,
    required this.scrollToHadithId,
    required this.onScrollToHadith,
    required this.onShowSnackBar,
    super.key,
  });

  final ScrollController scrollController;
  final AppLocalizations localizations;
  final bool isArabic;
  final int? scrollToHadithId;
  final Function(HadithCubit) onScrollToHadith;
  final Function(String) onShowSnackBar;

  @override
  Widget build(BuildContext context) => BlocBuilder<HadithCubit, HadithState>(
    builder: (context, state) {
      final cubit = context.read<HadithCubit>();

      if (state is HadithInitial || state is HadithLoading) {
        return const CustomLoadingIndicator(text: 'جاري تحميل الأحاديث');
      } else if (state is HadithLoaded) {
        onScrollToHadith(cubit);
        return HadithsList(
          scrollController: scrollController,
          hadiths: state.hadiths,
          isArabic: isArabic,
          localizations: localizations,
          cubit: cubit,
          onShowSnackBar: onShowSnackBar,
        );
      } else if (state is HadithError) {
        return ErrorState(
          message: state.message,
          localizations: localizations,
          onRetry: cubit.initializeData,
        );
      } else {
        return const CustomLoadingIndicator(text: 'جاري تحميل الأحاديث');
      }
    },
  );
}
