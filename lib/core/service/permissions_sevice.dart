import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestAllPermissions() async {
  try {
    await checkNotificationPermission();
    final locationGranted = await checkLocationPermission();
    await checkBatteryOptimization();
    return locationGranted;
  } catch (e) {
    debugPrint('Permission request error: $e');
    return false;
  }
}

Future<void> checkNotificationPermission() async {
  final status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
  if (status.isPermanentlyDenied) {
    await openAppSettings();
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
  try {
    final isDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled;

    if (isDisabled == false) {
      await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    } else {
      debugPrint('✅ التطبيق غير محسن (Unrestricted)');
    }
  } catch (e) {
    debugPrint('⚠️ خطأ في التحقق من Battery Optimization: $e');
  }
}
