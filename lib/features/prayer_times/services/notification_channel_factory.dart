import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../helper/notification_constants.dart';

/// Factory for creating notification channels used by the prayer_times feature.
///
/// Centralizes channel configuration that was previously duplicated in
/// [AppInitializer] and [WorkManagerService].
abstract final class NotificationChannelFactory {
  /// Creates the prayer reminder notification channel.
  static NotificationChannel prayerChannel() => NotificationChannel(
    channelKey: NotificationConstants.prayerChannelKey,
    channelName: NotificationConstants.prayerChannelName,
    channelDescription: NotificationConstants.prayerChannelDescription,
    defaultColor: NotificationConstants.prayerChannelColor,
    ledColor: Colors.white,
    importance: NotificationImportance.Max,
    playSound: true,
    enableVibration: false,
    enableLights: true,
    locked: false,
    defaultRingtoneType: DefaultRingtoneType.Notification,
    soundSource: NotificationConstants.prayerSoundSource,
    icon: NotificationConstants.notificationIcon,
    onlyAlertOnce: true,
    criticalAlerts: true,
  );
}
