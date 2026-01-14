// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_state_manager/internet_state_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../view_model/hadith/hadith_cubit.dart';
import '../../../view_model/hadith/hadith_state.dart';
import 'widgets/hadith_body.dart';

class HadithView extends StatefulWidget {
  const HadithView({
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
    required this.localizations,
    this.scrollToHadithId,
    super.key,
  });

  final String bookSlug;
  final String chapterNumber;
  final String chapterName;
  final AppLocalizations localizations;
  final int? scrollToHadithId;

  @override
  State<HadithView> createState() => _HadithViewState();
}

class _HadithViewState extends State<HadithView> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  bool _initialScrollAttempted = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _handleStateChanges(HadithState state, HadithCubit cubit) {
    if (state is HadithError) {
      _showErrorSnackBar(state.message);
    } else if (state is HadithLoaded) {
      _scrollToInitialHadith(cubit);
    }
  }

  void _scrollToInitialHadith(HadithCubit cubit) {
    if (!_initialScrollAttempted && widget.scrollToHadithId != null) {
      _initialScrollAttempted = true;
      // Delay slightly to ensure the list is built
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _scrollToHadith(widget.scrollToHadithId!, cubit);
        }
      });
    }
  }

  void _scrollToHadith(int hadithId, HadithCubit cubit) {
    final state = cubit.state;
    if (state is HadithLoaded) {
      final index = state.hadiths.indexWhere(
        (h) => int.parse(h.id) == hadithId,
      );

      if (index != -1) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return BlocListener<HadithCubit, HadithState>(
      listener: (context, state) =>
          _handleStateChanges(state, context.read<HadithCubit>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.localizations.hadithsTitle} ${widget.chapterName}',
          ),
        ),
        body: InternetStateManager(
          onRestoreInternetConnection: () {
            context.read<HadithCubit>().initializeData();
          },
          noInternetScreen: const NoInternetScreen(),
          child: RefreshIndicator(
            onRefresh: () => context.read<HadithCubit>().initializeData(),
            child: HadithsBody(
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              localizations: widget.localizations,
              isArabic: isArabic,
              scrollToHadithId: widget.scrollToHadithId,
              onScrollToHadith: _scrollToInitialHadith,
              onShowSnackBar: _showSnackBar,
            ),
          ),
        ),
      ),
    );
  }
}
