import 'package:flutter/material.dart';
import 'package:muslim/features/surahs_list/view/widgets/bookmark_tab/bookmark_tab.dart';
import 'package:muslim/l10n/app_localizations.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({
    required this.reciter,
    super.key,
  });

  final String reciter;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.bookmarksText)),
      body: BookmarksTab(
        reciter: reciter,
        localizations: localizations,
      ),
    );
  }
}
