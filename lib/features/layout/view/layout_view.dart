// layout_screen.dart
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
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
      appBar: AppBar(title: Text(localization.appName)),
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
