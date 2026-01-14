import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/view/settings_view.dart';
import 'widgets/layout_content.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appName),
        actions: [
          IconButton(
            onPressed: () =>
                navigateWithTransition(context, const SettingsView()),
            icon: const Icon(Icons.settings_rounded),
            tooltip: localization.settingsButton,
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) => LayoutContent(
            scaffoldContext,
            theme,
            localizations: localization,
            isArabic: isArabic,
          ),
        ),
      ),
    );
  }
}
