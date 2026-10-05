import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/hadith/presentation/bloc/hadith_bloc.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/widgets/hadith_error.dart';
import 'package:muslim/features/hadith/presentation/views/widgets/hadith_view/widgets/hadith_list.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HadithsBody extends StatelessWidget {
  const HadithsBody({
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.localizations,
    required this.scrollToHadithId,
    required this.onScrollToHadith,
    required this.onShowSnackBar,
    super.key,
  });

  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final AppLocalizations localizations;
  final int? scrollToHadithId;
  final void Function(HadithBloc) onScrollToHadith;
  final void Function(String) onShowSnackBar;

  @override
  Widget build(BuildContext context) => BlocBuilder<HadithBloc, HadithState>(
    builder: (context, state) {
      final bloc = context.read<HadithBloc>();

      if (state.status == HadithStatus.initial ||
          state.status == HadithStatus.loading) {
        return const CustomLoadingIndicator(text: 'جاري تحميل الأحاديث');
      } else if (state.status == HadithStatus.success) {
        return HadithsList(
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          hadiths: state.hadiths,
          localizations: localizations,
          bloc: bloc,
          onShowSnackBar: onShowSnackBar,
        );
      } else if (state.status == HadithStatus.error) {
        return ErrorState(
          message: state.message ?? '',
          localizations: localizations,
          onRetry: bloc.reloadData,
        );
      } else {
        return const CustomLoadingIndicator(text: 'جاري تحميل الأحاديث');
      }
    },
  );
}
