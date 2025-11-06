import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import 'app_info_section.dart';
import 'font_size_section.dart';
import 'language_section.dart';
import 'notification_switch.dart';
import 'rectire_section.dart';
import 'theme_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    required this.localizations,
    required this.isArabic,
    required this.theme,
    super.key,
  });

  final AppLocalizations localizations;
  final bool isArabic;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const divider = Divider(thickness: 0.05);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          FontSizeSection(localizations: localizations, theme: theme),
          divider,
          ThemeSection(localizations: localizations, theme: theme),
          divider,
          NotificationSection(isArabic: isArabic, theme: theme),
          divider,
          ReciterSection(
            localizations: localizations,
            isArabic: isArabic,
            theme: theme,
          ),
          divider,
          LanguageSection(localizations: localizations, theme: theme),
          divider,
          AppInfoSection(localizations: localizations, theme: theme),
        ],
      ),
    );
  }
}
