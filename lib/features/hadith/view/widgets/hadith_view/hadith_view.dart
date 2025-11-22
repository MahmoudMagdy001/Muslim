// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _initialScrollAttempted = false;

  @override
  void dispose() {
    _scrollController.dispose();
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

  void _handleStateChanges(HadithState state) {
    if (state is HadithError) {
      _showErrorSnackBar(state.message);
    }
  }

  void _scrollToInitialHadith(HadithCubit cubit) {
    if (!_initialScrollAttempted && widget.scrollToHadithId != null) {
      _initialScrollAttempted = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToHadith(widget.scrollToHadithId!, cubit);
      });
    }
  }

  void _scrollToHadith(int hadithId, HadithCubit cubit) {
    final key = cubit.hadithKeys[hadithId];

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _scrollToHadith(hadithId, cubit);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    return BlocProvider(
      create: (context) => HadithCubit(
        bookSlug: widget.bookSlug,
        chapterNumber: widget.chapterNumber,
        chapterName: widget.chapterName,
      )..initializeData(),
      child: BlocListener<HadithCubit, HadithState>(
        listener: (context, state) => _handleStateChanges(state),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${widget.localizations.hadithsTitle} ${widget.chapterName}',
            ),
          ),
          body: HadithsBody(
            scrollController: _scrollController,
            localizations: widget.localizations,
            isArabic: isArabic,
            scrollToHadithId: widget.scrollToHadithId,
            onScrollToHadith: _scrollToInitialHadith,
            onShowSnackBar: _showSnackBar,
          ),
        ),
      ),
    );
  }
}
