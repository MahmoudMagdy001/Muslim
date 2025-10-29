import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import 'app_info_section.dart';
import 'font_size_section.dart';
import 'language_section.dart';
import 'rectire_section.dart';
import 'theme_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    required this.localizations,
    required this.isArabic,
    super.key,
  });
  final AppLocalizations localizations;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    const divider = Divider(thickness: 0.05);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FontSizeSection(localizations: localizations),
          divider,
          ThemeSection(localizations: localizations),
          divider,
          ReciterSection(localizations: localizations, isArabic: isArabic),
          divider,
          LanguageSection(localizations: localizations),
          divider,
          AppInfoSection(localizations: localizations),
        ],
      ),
    );
  }
}
