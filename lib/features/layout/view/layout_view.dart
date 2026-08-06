import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim/core/utils/navigation_helper.dart';
import 'package:muslim/core/utils/overmark_helper.dart';
import 'package:muslim/features/layout/view/widgets/layout_content.dart';
import 'package:muslim/features/settings/view/settings_view.dart';
import 'package:muslim/l10n/app_localizations.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(AppTourHelper.showHomeTour(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appName),
        actions: [
          IconButton(
            onPressed: () => unawaited(
              AppTourHelper.showHomeTour(context, force: true),
            ),
            icon: const Icon(Icons.explore_outlined),
            tooltip: localization.tourServicesTitle,
          ),
          IconButton(
            key: AppTourKeys.settingsKey,
            onPressed: () =>
                unawaited(navigateWithTransition<void>(context, const SettingsView())),
            icon: const Icon(Icons.settings_rounded),
            tooltip: localization.settingsButton,
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) => LayoutContent(
            scaffoldContext,
            localizations: localization,
            isArabic: isArabic,
          ),
        ),
      ),
    );
  }
}
