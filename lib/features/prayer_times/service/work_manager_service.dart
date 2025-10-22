import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'prayer_notification_service.dart';
import 'prayer_times_service.dart';

const String updatePrayerTimesTask = 'update_prayer_times_task';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    // ✅ تهيئة AwesomeNotifications داخل الـ isolate
    await AwesomeNotifications()
        .initialize('resource://drawable/ic_muslim_logo', [
          NotificationChannel(
            channelKey: 'prayer_reminder',
            channelName: 'تذكير الصلاة',
            channelDescription: 'إشعارات بمواقيت الصلاة وتشغيل الأذان',
            defaultColor: const Color(0xFF33A1E0),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
            locked: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
            soundSource: 'resource://raw/azan',
            icon: 'resource://drawable/ic_muslim_logo',
          ),
        ]);

    // ✅ تأكيد تحميل المنطقة الزمنية (Workaround)
    final now = DateTime.now();
    debugPrint(
      '🕒 Timezone initialized: ${now.timeZoneName}, offset: ${now.timeZoneOffset}',
    );

    debugPrint('🎯 WorkManager اشتغل! المهمة: $task - الوقت: $now');

    try {
      final prayerService = PrayerTimesService();
      final notificationService = PrayerNotificationService();
      final times = await prayerService.getPrayerTimes();
      await notificationService.schedulePrayerNotifications(times);

      debugPrint(
        '✅ تمت جدولة مواقيت الصلاة بنجاح في الخلفية - ${DateTime.now()}',
      );
      return Future.value(true);
    } catch (e, s) {
      debugPrint('💥 خطأ في WorkManager: $e');
      debugPrint('$s');
      return Future.value(false);
    }
  });
}
