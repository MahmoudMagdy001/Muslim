import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/permissions_sevice.dart';
import '../../../prayer_times/service/prayer_notification_service.dart';
import '../../../prayer_times/viewmodel/prayer_times_cubit.dart';

class PrayerNotificationSwitch extends StatefulWidget {
  const PrayerNotificationSwitch({
    required this.isArabic,
    required this.theme,
    super.key,
  });
  final bool isArabic;
  final ThemeData theme;

  @override
  State<PrayerNotificationSwitch> createState() =>
      _PrayerNotificationSwitchState();
}

class _PrayerNotificationSwitchState extends State<PrayerNotificationSwitch> {
  bool _notificationsEnabled = true;
  final PrayerNotificationService _prayerNotificationService =
      PrayerNotificationService();

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('prayer_notifications') ?? true;
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('prayer_notifications', value);

    setState(() {
      _notificationsEnabled = value;
    });

    if (!value) {
      await _prayerNotificationService.cancelAllNotifications();
    } else {
      await requestAllPermissions();
      if (mounted) {
        context.read<PrayerTimesCubit>().init(isArabic: widget.isArabic);
      }
    }

    // عرض Snackbar بعد التغيير
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value ? 'تم تفعيل إشعارات الأذان' : 'تم تعطيل إشعارات الأذان',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => ListTile(
    leading: const Icon(Icons.notifications_rounded),
    title: Text('إشعارات الأذان', style: widget.theme.textTheme.titleMedium),
    trailing: Switch(
      value: _notificationsEnabled,
      onChanged: _toggleNotifications,
    ),
  );
}
