import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/settings/view/widgets/settings_content.dart';
import 'package:muslim/l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settingsButton)),
      body: SettingsContent(
        localizations: localizations,
        theme: theme,
      ),
    );
  }
}
