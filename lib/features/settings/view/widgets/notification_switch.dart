import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/permissions_sevice.dart';
import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer_times/models/prayer_notification_settings_model.dart';
import '../../../prayer_times/models/prayer_type.dart';
import '../../../prayer_times/viewmodel/prayer_times_cubit.dart';
import '../../../prayer_times/viewmodel/prayer_times_state.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({
    required this.isArabic,
    required this.theme,
    super.key,
  });

  final bool isArabic;
  final ThemeData theme;

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  final _NotificationSettingsManager _settingsManager =
      _NotificationSettingsManager();
  final _QuranNotificationService _quranNotificationService =
      _QuranNotificationService();

  final ValueNotifier<_NotificationSettings> settingsNotifier = ValueNotifier(
    const _NotificationSettings(),
  );

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    settingsNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final settings = await _settingsManager.loadSettings();
    settingsNotifier.value = settings;
  }

  Future<void> _toggleQuranNotifications(bool value) async {
    await _settingsManager.saveQuranNotifications(value);

    settingsNotifier.value = settingsNotifier.value.copyWith(
      quranNotifications: value,
    );

    if (!value) {
      await _quranNotificationService.cancelAllNotifications();
    } else {
      if (mounted) {
        await _quranNotificationService.scheduleDailyReminder(context);
      }
    }

    if (!mounted) return;
    _showSnackBar(
      value
          ? AppLocalizations.of(context).quranRemindersEnabled
          : AppLocalizations.of(context).quranRemindersDisabled,
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ListTile(
      leading: const Icon(Icons.notifications_rounded),
      title: Text(
        localizations.appNotifications,
        style: widget.theme.textTheme.titleMedium,
      ),
      trailing: const Icon(Icons.arrow_drop_down_rounded),
      onTap: () => _showNotificationSettingsModal(localizations),
    );
  }

  void _showNotificationSettingsModal(AppLocalizations localizations) {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => ValueListenableBuilder<_NotificationSettings>(
        valueListenable: settingsNotifier,
        builder: (context, settings, child) => _NotificationSettingsModal(
          theme: widget.theme,
          localizations: localizations,
          isArabic: widget.isArabic,
          settings: settings,
          onQuranNotificationsChanged: _toggleQuranNotifications,
        ),
      ),
    );
  }
}

class _NotificationSettingsModal extends StatelessWidget {
  const _NotificationSettingsModal({
    required this.theme,
    required this.localizations,
    required this.isArabic,
    required this.settings,
    required this.onQuranNotificationsChanged,
  });

  final ThemeData theme;
  final AppLocalizations localizations;
  final bool isArabic;
  final _NotificationSettings settings;
  final ValueChanged<bool> onQuranNotificationsChanged;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Prayer Notifications Header
      ListTile(
        leading: Icon(Icons.mosque_rounded, color: theme.colorScheme.primary),
        title: Text(
          localizations.enablePrayerNotifications,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Per-prayer toggles
      _PerPrayerSettingsSection(theme: theme, isArabic: isArabic),

      Divider(height: 24.toH, indent: 16.toW, endIndent: 16.toW),

      _NotificationSwitchTile(
        icon: Icons.auto_stories_rounded,
        title: localizations.enableQuranReminders,
        value: settings.quranNotifications,
        onChanged: onQuranNotificationsChanged,
        theme: theme,
      ),
      SizedBox(height: 12.toH),
    ],
  );
}

/// Per-prayer notification toggles section.
///
/// Uses [BlocBuilder] to read notification settings from [PrayerTimesCubit].
class _PerPrayerSettingsSection extends StatelessWidget {
  const _PerPrayerSettingsSection({
    required this.theme,
    required this.isArabic,
  });

  final ThemeData theme;
  final bool isArabic;

  @override
  Widget build(BuildContext context) =>
      BlocSelector<
        PrayerTimesCubit,
        PrayerTimesState,
        PrayerNotificationSettings
      >(
        selector: (state) => state.notificationSettings,
        builder: (context, notificationSettings) => Padding(
          padding: EdgeInsets.only(left: 24.toW),
          child: Column(
            children: PrayerType.values.map((prayer) {
              final enabled = notificationSettings.isEnabled(prayer);
              return _NotificationSwitchTile(
                icon: Icons.notifications_active_rounded,
                title: prayer.displayName(isArabic: isArabic),
                value: enabled,
                onChanged: (value) async {
                  // Request permissions if enabling a notification
                  if (value) {
                    await requestAllPermissions();
                  }

                  if (context.mounted) {
                    context.read<PrayerTimesCubit>().togglePrayerNotification(
                      prayer,
                      enabled: value,
                    );
                  }
                },
                theme: theme,
                dense: true,
              );
            }).toList(),
          ),
        ),
      );
}

class _NotificationSwitchTile extends StatelessWidget {
  const _NotificationSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.theme,
    this.dense = false,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ThemeData theme;
  final bool dense;

  @override
  Widget build(BuildContext context) => ListTile(
    dense: dense,
    leading: Icon(icon, size: dense ? 20.toW : null),
    title: Text(
      title,
      style: dense ? theme.textTheme.bodyMedium : theme.textTheme.titleMedium,
    ),
    trailing: Switch(value: value, onChanged: onChanged),
  );
}

// ── Private helpers (kept in this file for settings UI scope) ──────────

class _NotificationSettings {
  const _NotificationSettings({this.quranNotifications = true});
  final bool quranNotifications;

  _NotificationSettings copyWith({bool? quranNotifications}) =>
      _NotificationSettings(
        quranNotifications: quranNotifications ?? this.quranNotifications,
      );
}

class _NotificationSettingsManager {
  static const String _quranNotificationsKey = 'quran_notifications';

  Future<_NotificationSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return _NotificationSettings(
      quranNotifications: prefs.getBool(_quranNotificationsKey) ?? true,
    );
  }

  Future<void> saveQuranNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotificationsKey, value);
  }
}

class _QuranNotificationService {
  static const String _channelKey = 'quran_channel';

  Future<void> cancelAllNotifications() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);
      debugPrint('تم إلغاء جميع إشعارات القرآن');
    } catch (e) {
      debugPrint('⚠️ حدث خطأ أثناء إلغاء إشعارات القرآن: $e');
    }
  }

  Future<void> scheduleDailyReminder(BuildContext context) async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);
      await AwesomeNotifications().cancelSchedulesByChannelKey('quran_channel');

      final DateTime now = DateTime.now();
      final DateTime firstNotification = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour + 1,
      );

      if (!context.mounted) return;
      final localizations = AppLocalizations.of(context);

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'quran_channel',
          title: localizations.quranReminderTitle,
          body: localizations.quranReminderBody,
        ),
        schedule: NotificationAndroidCrontab.hourly(
          referenceDateTime: firstNotification,
          allowWhileIdle: true,
        ),
      );
    } catch (e) {
      debugPrint('❌ خطأ أثناء جدولة إشعار القرآن: $e');
    }
  }
}
