import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/service/in_app_rate.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'app_info_section.dart';
import 'font_size_section.dart';
import 'notification_switch.dart';
import 'rectire_section.dart';
import 'theme_section.dart';
import 'location_section.dart';

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
  final ValueNotifier<String?> appVersionNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAppInfo();
    });
  }

  @override
  void dispose() {
    appVersionNotifier.dispose();
    super.dispose();
  }

  Future<void> _fetchAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersionNotifier.value = packageInfo.version;
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

          ReciterSection(
            localizations: widget.localizations,
            isArabic: widget.isArabic,
            theme: widget.theme,
          ),
          divider,

          NotificationSection(isArabic: widget.isArabic, theme: widget.theme),
          divider,
          LocationSection(isArabic: widget.isArabic, theme: widget.theme),
          divider,
          ValueListenableBuilder<String?>(
            valueListenable: appVersionNotifier,
            builder: (context, appVersion, child) => AppInfoSection(
              localizations: widget.localizations,
              theme: widget.theme,
              appVersion: appVersion ?? '...',
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 زر التقييم اليدوي في آخر الصفحة
          ElevatedButton.icon(
            onPressed: () => RateAppHelper.rateNow(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.toR),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.toW,
                vertical: 12.toH,
              ),
            ),
            icon: Icon(
              Icons.star_rate_rounded,
              color: widget.theme.colorScheme.onPrimary,
            ),
            label: Text(
              widget.isArabic ? 'قيّم التطبيق' : 'Rate App',
              style: widget.theme.textTheme.labelLarge?.copyWith(
                color: widget.theme.colorScheme.onPrimary,
                fontSize: 16.toSp,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
