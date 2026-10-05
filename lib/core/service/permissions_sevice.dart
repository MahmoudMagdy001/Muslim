import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:muslim/core/service/native_battery_service.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestAllPermissions({bool includeBattery = true}) async {
  try {
    await checkNotificationPermission();
  } on Object catch (e) {
    debugPrint('Notification permission error: $e');
  }

  var locationGranted = false;
  try {
    locationGranted = await checkLocationPermission();
  } on Object catch (e) {
    debugPrint('Location permission error: $e');
  }

  if (includeBattery) {
    try {
      await checkBatteryOptimization();
    } on Object catch (e) {
      debugPrint('Battery optimization check error: $e');
    }
  }

  return locationGranted;
}

// ponytail: check location permission status without showing a blocking prompt
Future<bool> isLocationPermissionGranted() async => Permission.locationWhenInUse.isGranted;

Future<void> checkNotificationPermission() async {
  try {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  } on Object catch (e) {
    debugPrint('Notification permission request error: $e');
  }
}

Future<bool> checkLocationPermission() async {
  final status = await Permission.locationWhenInUse.status;
  if (status.isDenied) {
    final result = await Permission.locationWhenInUse.request();
    return result.isGranted;
  }
  if (status.isPermanentlyDenied) {
    await openAppSettings();
    return false;
  }
  return status.isGranted;
}

Future<void> checkBatteryOptimization() async {
  await NativeBatteryService.requestIfNeeded();
}
