import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestAllPermissions() async {
  try {
    await checkNotificationPermission();
    await checkLocationPermission();
    await checkBatteryOptimization();
  } catch (e) {
    debugPrint('Permission request error: $e');
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

Future<void> checkLocationPermission() async {
  final status = await Permission.locationWhenInUse.status;
  if (status.isDenied) {
    await Permission.locationWhenInUse.request();
  }
  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
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
