import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../l10n/app_localizations.dart';
import 'app_info_section.dart';
import 'font_size_section.dart';
import 'language_section.dart';
import 'notification_switch.dart';
import 'rectire_section.dart';
import 'theme_section.dart';

class SettingsContent extends StatefulWidget {
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
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  String? appVersion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAppInfo();
    });
  }

  Future<void> _fetchAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint('❌ Failed to get package info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(thickness: 0.05);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          FontSizeSection(
            localizations: widget.localizations,
            theme: widget.theme,
          ),
          divider,
          ThemeSection(
            localizations: widget.localizations,
            theme: widget.theme,
          ),
          divider,
          NotificationSection(isArabic: widget.isArabic, theme: widget.theme),
          divider,
          ReciterSection(
            localizations: widget.localizations,
            isArabic: widget.isArabic,
            theme: widget.theme,
          ),
          divider,
          LanguageSection(
            localizations: widget.localizations,
            theme: widget.theme,
          ),
          divider,
          AppInfoSection(
            localizations: widget.localizations,
            theme: widget.theme,
            appVersion: appVersion ?? '...',
          ),
        ],
      ),
    );
  }
}
