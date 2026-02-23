import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/permissions_sevice.dart';
import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer_times/helper/prayer_consts.dart';
import '../../../prayer_times/models/prayer_notification_settings_model.dart';
import '../../../prayer_times/models/prayer_type.dart';
import '../../../prayer_times/viewmodel/prayer_times_cubit.dart';
import '../../../prayer_times/viewmodel/prayer_times_state.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PUBLIC API
// ─────────────────────────────────────────────────────────────────────────────

/// A settings section widget for managing app notifications.
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

// ─────────────────────────────────────────────────────────────────────────────
// STATE
// ─────────────────────────────────────────────────────────────────────────────

class _NotificationSectionState extends State<NotificationSection> {
  late final NotificationSettingsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotificationSettingsController(
      onSettingsChanged: _handleSettingsChange,
    );
    _controller.loadSettings();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSettingsChange(NotificationSettings settings) {
    if (!mounted) return;

    final message = settings.quranNotifications
        ? AppLocalizations.of(context).quranRemindersEnabled
        : AppLocalizations.of(context).quranRemindersDisabled;

    _showSnackBar(message);
  }

  void _showSnackBar(String message) {
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
      builder: (context) => NotificationSettingsModal(
        theme: widget.theme,
        localizations: localizations,
        isArabic: widget.isArabic,
        controller: _controller,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MODAL WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class NotificationSettingsModal extends StatelessWidget {
  const NotificationSettingsModal({
    required this.theme,
    required this.localizations,
    required this.isArabic,
    required this.controller,
    super.key,
  });

  final ThemeData theme;
  final AppLocalizations localizations;
  final bool isArabic;
  final NotificationSettingsController controller;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, child) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPrayerNotificationsHeader(),
        _PerPrayerSettingsSection(theme: theme, isArabic: isArabic),
        Divider(height: 24.toH, indent: 16.toW, endIndent: 16.toW),
        _buildQuranNotificationTile(),
        SizedBox(height: 12.toH),
      ],
    ),
  );

  Widget _buildPrayerNotificationsHeader() => ListTile(
    title: Text(
      localizations.enablePrayerNotifications,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildQuranNotificationTile() => NotificationSwitchTile(
    icon: Icons.auto_stories_rounded,
    title: localizations.enableQuranReminders,
    value: controller.settings.quranNotifications,
    onChanged: controller.toggleQuranNotifications,
    theme: theme,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// PER-PRAYER SETTINGS
// ─────────────────────────────────────────────────────────────────────────────

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
            children: PrayerType.values
                .where((prayer) => prayer.hasAzan)
                .map(
                  (prayer) =>
                      _buildPrayerTile(context, prayer, notificationSettings),
                )
                .toList(),
          ),
        ),
      );

  Widget _buildPrayerTile(
    BuildContext context,
    PrayerType prayer,
    PrayerNotificationSettings settings,
  ) {
    final visual = prayerVisuals[prayer]!;
    final enabled = settings.isEnabled(prayer);

    return NotificationSwitchTile(
      icon: visual.icon,
      title: prayer.displayName(isArabic: isArabic),
      value: enabled,
      onChanged: (value) => _handlePrayerToggle(context, prayer, value),
      theme: theme,
    );
  }

  Future<void> _handlePrayerToggle(
    BuildContext context,
    PrayerType prayer,
    bool value,
  ) async {
    if (value) {
      await requestAllPermissions();
    }

    if (context.mounted) {
      context.read<PrayerTimesCubit>().togglePrayerNotification(
        prayer,
        enabled: value,
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE UI COMPONENTS
// ─────────────────────────────────────────────────────────────────────────────

class NotificationSwitchTile extends StatelessWidget {
  const NotificationSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.theme,
    this.dense = false,
    super.key,
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

// ─────────────────────────────────────────────────────────────────────────────
// CONTROLLER (Business Logic)
// ─────────────────────────────────────────────────────────────────────────────

/// Controls notification settings state and persistence.
class NotificationSettingsController extends ChangeNotifier {
  NotificationSettingsController({
    required this.onSettingsChanged,
    NotificationRepository? repository,
    QuranNotificationService? quranService,
  }) : _repository = repository ?? NotificationRepository(),
       _quranService = quranService ?? QuranNotificationService();

  final NotificationRepository _repository;
  final QuranNotificationService _quranService;
  final void Function(NotificationSettings settings) onSettingsChanged;

  NotificationSettings _settings = const NotificationSettings();

  NotificationSettings get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await _repository.loadSettings();
    notifyListeners();
  }

  Future<void> toggleQuranNotifications(bool value) async {
    await _repository.saveQuranNotifications(value);

    _settings = _settings.copyWith(quranNotifications: value);
    notifyListeners();

    await _applyQuranNotificationState(value);
    onSettingsChanged(_settings);
  }

  Future<void> _applyQuranNotificationState(bool enabled) async {
    if (enabled) {
      await _quranService.scheduleDailyReminder();
    } else {
      await _quranService.cancelAllNotifications();
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REPOSITORY (Data Layer)
// ─────────────────────────────────────────────────────────────────────────────

/// Handles persistence of notification preferences.
class NotificationRepository {
  static const String _quranNotificationsKey = 'quran_notifications';

  Future<NotificationSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationSettings(
      quranNotifications: prefs.getBool(_quranNotificationsKey) ?? true,
    );
  }

  Future<void> saveQuranNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotificationsKey, value);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SERVICE (Notification Scheduling)
// ─────────────────────────────────────────────────────────────────────────────

/// Manages Quran notification scheduling using Awesome Notifications.
class QuranNotificationService {
  static const String _channelKey = 'quran_channel';

  Future<void> cancelAllNotifications() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);
      debugPrint('تم إلغاء جميع إشعارات القرآن');
    } catch (e, stackTrace) {
      debugPrint('⚠️ حدث خطأ أثناء إلغاء إشعارات القرآن: $e');
      debugPrint(stackTrace.toString());
    }
  }

  Future<void> scheduleDailyReminder() async {
    try {
      await _clearExistingSchedules();
      await _createHourlyReminder();
    } catch (e, stackTrace) {
      debugPrint('❌ خطأ أثناء جدولة إشعار القرآن: $e');
      debugPrint(stackTrace.toString());
    }
  }

  Future<void> _clearExistingSchedules() async {
    await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);
  }

  Future<void> _createHourlyReminder() async {
    final now = DateTime.now();
    final firstNotification = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour + 1,
    );

    // Note: This requires context for localization - consider injecting localizations
    // or using a different approach to avoid BuildContext dependency
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: _channelKey,
        title: 'Quran Reminder',
        body: 'Time to read Quran',
      ),
      schedule: NotificationAndroidCrontab.hourly(
        referenceDateTime: firstNotification,
        allowWhileIdle: true,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────────────────────────────────────

@immutable
class NotificationSettings {
  const NotificationSettings({this.quranNotifications = true});

  final bool quranNotifications;

  NotificationSettings copyWith({bool? quranNotifications}) =>
      NotificationSettings(
        quranNotifications: quranNotifications ?? this.quranNotifications,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettings &&
          runtimeType == other.runtimeType &&
          quranNotifications == other.quranNotifications;

  @override
  int get hashCode => quranNotifications.hashCode;
}
