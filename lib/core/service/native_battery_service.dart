import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Native battery optimization service via [MethodChannel].
///
/// Replaces the `disable_battery_optimization` package.
/// Works on Android only — no-ops silently on other platforms.
abstract final class NativeBatteryService {
  static const _channel = MethodChannel('com.mahmoud.muslim/battery_optimization');

  /// Returns `true` if the app is already ignoring battery optimizations.
  static Future<bool> isIgnoring() async {
    if (!defaultTargetPlatform.isAndroid) return true;
    try {
      return await _channel.invokeMethod<bool>('isIgnoringBatteryOptimizations') ?? false;
    } on PlatformException catch (e) {
      debugPrint('⚠️ isIgnoringBatteryOptimizations error: $e');
      return false;
    }
  }

  /// Opens the system dialog asking the user to ignore battery optimizations
  /// for this app. Does nothing if already ignoring.
  static Future<void> requestIfNeeded() async {
    if (!defaultTargetPlatform.isAndroid) return;
    try {
      final alreadyIgnoring = await isIgnoring();
      if (alreadyIgnoring) {
        debugPrint('✅ Battery optimization already disabled');
        return;
      }
      await _channel.invokeMethod<void>('requestIgnoreBatteryOptimizations');
    } on PlatformException catch (e) {
      debugPrint('⚠️ requestIgnoreBatteryOptimizations error: $e');
    }
  }
}

extension on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
}
