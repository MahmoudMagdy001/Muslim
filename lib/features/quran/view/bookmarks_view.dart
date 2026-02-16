import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../surahs_list/view/widgets/bookmark_tab/bookmark_tab.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({
    required this.reciter,
    required this.isArabic,
    super.key,
  });

  final String reciter;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.bookmarksText)),
      body: BookmarksTab(
        reciter: reciter,
        localizations: localizations,
        isArabic: isArabic,
      ),
    );
  }
}
