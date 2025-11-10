import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/permissions_sevice.dart';
import '../../../../core/utils/custom_modal_sheet.dart';
import '../../../prayer_times/service/prayer_notification_service.dart';
import '../../../prayer_times/viewmodel/prayer_times_cubit.dart';

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
  final NotificationSettingsManager _settingsManager =
      NotificationSettingsManager();
  final QuranNotificationService _quranNotificationService =
      QuranNotificationService();
  final PrayerNotificationService _prayerNotificationService =
      PrayerNotificationService();

  NotificationSettings _settings = const NotificationSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _settingsManager.loadSettings();
    setState(() => _settings = settings);
  }

  Future<void> _togglePrayerNotifications(bool value) async {
    await _settingsManager.savePrayerNotifications(value);

    setState(() => _settings = _settings.copyWith(prayerNotifications: value));

    if (!value) {
      await _prayerNotificationService.cancelAllNotifications();
    } else {
      await requestAllPermissions();
      if (mounted) {
        context.read<PrayerTimesCubit>().init(isArabic: widget.isArabic);
      }
    }

    _showSnackBar(
      value ? 'تم تفعيل إشعارات الأذان' : 'تم تعطيل إشعارات الأذان',
    );
  }

  Future<void> _toggleQuranNotifications(bool value) async {
    await _settingsManager.saveQuranNotifications(value);

    setState(() => _settings = _settings.copyWith(quranNotifications: value));

    if (!value) {
      await _quranNotificationService.cancelAllNotifications();
    } else {
      await _quranNotificationService.scheduleDailyReminder();
    }

    _showSnackBar(
      value ? 'تم تفعيل إشعارات تذكير القرآن' : 'تم تعطيل إشعارات تذكير القرآن',
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.notifications_rounded),
    title: Text('إشعارات التطبيق', style: widget.theme.textTheme.titleMedium),
    trailing: const Icon(Icons.arrow_drop_down_rounded),
    onTap: _showNotificationSettingsModal,
  );

  void _showNotificationSettingsModal() {
    showCustomModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => _NotificationSettingsModal(
          theme: widget.theme,
          settings: _settings,
          onPrayerNotificationsChanged: (value) async {
            await _togglePrayerNotifications(value);
            setModalState(() {});
          },
          onQuranNotificationsChanged: (value) async {
            await _toggleQuranNotifications(value);
            setModalState(() {});
          },
        ),
      ),
    );
  }
}

class _NotificationSettingsModal extends StatelessWidget {
  const _NotificationSettingsModal({
    required this.theme,
    required this.settings,
    required this.onPrayerNotificationsChanged,
    required this.onQuranNotificationsChanged,
  });

  final ThemeData theme;
  final NotificationSettings settings;
  final ValueChanged<bool> onPrayerNotificationsChanged;
  final ValueChanged<bool> onQuranNotificationsChanged;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _NotificationSwitchTile(
        icon: Icons.mosque_rounded,
        title: 'تفعيل اشعارات الأذان',
        value: settings.prayerNotifications,
        onChanged: onPrayerNotificationsChanged,
        theme: theme,
      ),
      const SizedBox(height: 12),
      _NotificationSwitchTile(
        icon: Icons.auto_stories_rounded,
        title: 'تفعيل اشعارات تذكير القران',
        value: settings.quranNotifications,
        onChanged: onQuranNotificationsChanged,
        theme: theme,
      ),
      const SizedBox(height: 12),
    ],
  );
}

class _NotificationSwitchTile extends StatelessWidget {
  const _NotificationSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon),
    title: Text(title, style: theme.textTheme.titleMedium),
    trailing: Switch(value: value, onChanged: onChanged),
  );
}

// Data model for notification settings
class NotificationSettings {
  const NotificationSettings({
    this.prayerNotifications = true,
    this.quranNotifications = true,
  });
  final bool prayerNotifications;
  final bool quranNotifications;

  NotificationSettings copyWith({
    bool? prayerNotifications,
    bool? quranNotifications,
  }) => NotificationSettings(
    prayerNotifications: prayerNotifications ?? this.prayerNotifications,
    quranNotifications: quranNotifications ?? this.quranNotifications,
  );
}

// Service for managing notification settings persistence
class NotificationSettingsManager {
  static const String _prayerNotificationsKey = 'prayer_notifications';
  static const String _quranNotificationsKey = 'quran_notifications';

  Future<NotificationSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationSettings(
      prayerNotifications: prefs.getBool(_prayerNotificationsKey) ?? true,
      quranNotifications: prefs.getBool(_quranNotificationsKey) ?? true,
    );
  }

  Future<void> savePrayerNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prayerNotificationsKey, value);
  }

  Future<void> saveQuranNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotificationsKey, value);
  }
}

// Service for Quran notifications
class QuranNotificationService {
  static const String _channelKey = 'quran_channel';

  Future<void> cancelAllNotifications() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);
      debugPrint('تم إلغاء جميع إشعارات القرآن');
    } catch (e) {
      debugPrint('⚠️ حدث خطأ أثناء إلغاء إشعارات القرآن: $e');
    }
  }

  Future<void> scheduleDailyReminder() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(_channelKey);

      // احذف أي إشعارات قديمة قبل جدولة الجديدة
      await AwesomeNotifications().cancelSchedulesByChannelKey('quran_channel');

      final DateTime now = DateTime.now();

      final DateTime firstNotification = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour + 1,
      );

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'quran_channel',
          title: '📖 تذكير بقراءة القرآن',
          body: 'لا تنس وردك من القرآن الكريم 🌿',
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
