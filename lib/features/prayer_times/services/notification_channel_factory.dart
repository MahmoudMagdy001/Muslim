import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../helper/notification_constants.dart';

/// Creates the prayer reminder notification channel.
NotificationChannel createPrayerChannel() => NotificationChannel(
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
