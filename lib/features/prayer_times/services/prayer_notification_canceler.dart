import 'package:awesome_notifications/awesome_notifications.dart';

import '../../../core/utils/app_logger.dart';
import '../helper/notification_constants.dart';

/// Cancels scheduled prayer notifications.
class PrayerNotificationCanceler {
  /// Cancels all scheduled notifications on the prayer channel.
  Future<void> cancelAll() async {
    try {
      await AwesomeNotifications().cancelSchedulesByChannelKey(
        NotificationConstants.prayerChannelKey,
      );
      logInfo('تم إلغاء جميع إشعارات الصلاة السابقة');
    } catch (e) {
      logWarning('حدث خطأ أثناء إلغاء الإشعارات: $e');
    }
  }
}
