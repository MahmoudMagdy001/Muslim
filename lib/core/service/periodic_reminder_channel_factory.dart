import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'periodic_reminder_constants.dart';

/// Creates the periodic Islamic reminder notification channel.
NotificationChannel createPeriodicReminderChannel() => NotificationChannel(
  channelKey: PeriodicReminderConstants.reminderChannelKey,
  channelName: PeriodicReminderConstants.reminderChannelName,
  channelDescription: PeriodicReminderConstants.reminderChannelDescription,
  defaultColor: PeriodicReminderConstants.reminderChannelColor,
  ledColor: Colors.white,
  importance: NotificationImportance.High,
  playSound: true,
  enableVibration: true,
  enableLights: true,
  locked: false,
  defaultRingtoneType: DefaultRingtoneType.Notification,
  soundSource: PeriodicReminderConstants.reminderSoundSource,
  icon: PeriodicReminderConstants.notificationIcon,
  onlyAlertOnce: false,
  criticalAlerts: false,
);
