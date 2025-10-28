// layout_screen.dart
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'widgets/layout_content.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localization.appName)),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) => LayoutContent(
            scaffoldContext,
            theme,
            localizations: localization,
          ),
        ),
      ),
    );
  }
}
