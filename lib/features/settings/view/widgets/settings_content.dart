import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/service/in_app_rate.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/app_card.dart';
import 'package:muslim/core/widgets/section_header.dart';
import 'package:muslim/features/settings/view/widgets/app_info_section.dart';
import 'package:muslim/features/settings/view/widgets/font_size_section.dart';
import 'package:muslim/features/settings/view/widgets/location_section.dart';
import 'package:muslim/features/settings/view/widgets/notification_switch.dart';
import 'package:muslim/features/settings/view/widgets/periodic_reminder_section.dart';
import 'package:muslim/features/settings/view/widgets/rectire_section.dart';
import 'package:muslim/features/settings/view/widgets/theme_section.dart';
import 'package:muslim/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({
    required this.localizations,
    required this.theme,
    super.key,
  });

  final AppLocalizations localizations;
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
      unawaited(_fetchAppInfo());
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
    } on Object catch (e) {
      debugPrint('❌ Failed to get package info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Group 1: Appearance & Display
          SectionHeader(
            title: isArabic ? 'المظهر والقراءة' : 'Appearance & Display',
            padding: EdgeInsets.only(bottom: 6.h),
          ),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Column(
              children: [
                FontSizeSection(
                  localizations: widget.localizations,
                  theme: widget.theme,
                ),
                Divider(color: colors.border, height: 1),
                ThemeSection(
                  localizations: widget.localizations,
                  theme: widget.theme,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Group 2: Audio & Reminders
          SectionHeader(
            title: isArabic ? 'الصوت والتنبيهات' : 'Audio & Notifications',
            padding: EdgeInsets.only(bottom: 6.h),
          ),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Column(
              children: [
                ReciterSection(
                  localizations: widget.localizations,
                  theme: widget.theme,
                ),
                Divider(color: colors.border, height: 1),
                NotificationSection(theme: widget.theme),
                Divider(color: colors.border, height: 1),
                PeriodicReminderSection(theme: widget.theme),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Group 3: Location
          SectionHeader(
            title: isArabic ? 'الموقع ومواقيت الصلاة' : 'Location & Timings',
            padding: EdgeInsets.only(bottom: 6.h),
          ),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: LocationSection(theme: widget.theme),
          ),
          SizedBox(height: 16.h),

          // Group 4: About & Review
          SectionHeader(
            title: isArabic ? 'حول التطبيق' : 'About & Support',
            padding: EdgeInsets.only(bottom: 6.h),
          ),
          AppCard(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: ValueListenableBuilder<String?>(
              valueListenable: appVersionNotifier,
              builder: (context, appVersion, child) => AppInfoSection(
                localizations: widget.localizations,
                theme: widget.theme,
                appVersion: appVersion ?? '...',
              ),
            ),
          ),
          SizedBox(height: 20.h),

          _RateAppButton(theme: widget.theme),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _RateAppButton extends StatelessWidget {
  const _RateAppButton({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: ElevatedButton.icon(
        onPressed: () => RateAppHelper.rateNow(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          elevation: 0,
        ),
        icon: Icon(
          Icons.star_rate_rounded,
          color: colors.secondary,
          size: 20.r,
        ),
        label: Text(
          AppLocalizations.of(context).rateAppButton,
          style: context.typography.titleSmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
