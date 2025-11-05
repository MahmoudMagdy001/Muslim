import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'widgets/settings_content.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settingsButton)),
      body: SettingsContent(
        localizations: localizations,
        isArabic: isArabic,
        theme: theme,
      ),
    );
  }
}
