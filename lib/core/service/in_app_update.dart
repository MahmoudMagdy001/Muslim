// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/base_app_dialog.dart';

class AppUpdateService {
  static const String _packageName = 'com.mahmoud.muslim';
  static const String _lastDismissedKey = 'update_last_dismissed';
  static const int _daysBetweenPrompts = 3;

  /// 📱 استدعِها في أول شاشة من التطبيق
  static Future<void> checkForUpdate(BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      // ✅ التأكد من cooldown قبل السؤال
      if (await _isDismissCooldownActive()) {
        debugPrint('⏳ Update prompt cooldown active, skipping');
        return;
      }

      final info = await InAppUpdate.checkForUpdate();

      _logUpdateInfo(info);

      if (info.updateAvailability == UpdateAvailability.updateAvailable &&
          context.mounted) {
        if (info.immediateUpdateAllowed) {
          await _showImmediateUpdateDialog(context);
        } else if (info.flexibleUpdateAllowed) {
          await _showFlexibleUpdateDialog(context);
        }
      }
    } on PlatformException catch (e) {
      debugPrint('❌ Platform error: ${e.code} - ${e.message}');
    } catch (e, stackTrace) {
      debugPrint('❌ Error checking for update: $e');
      debugPrint('Stack: $stackTrace');
    }
  }

  // ─── Cooldown Logic ───────────────────────────────────────────

  static Future<bool> _isDismissCooldownActive() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDismissed = prefs.getInt(_lastDismissedKey) ?? 0;

    if (lastDismissed == 0) return false;

    final now = DateTime.now().millisecondsSinceEpoch;
    final daysSince = (now - lastDismissed) ~/ (1000 * 60 * 60 * 24);

    debugPrint('📊 Update cooldown: $daysSince days since last dismiss');
    return daysSince < _daysBetweenPrompts;
  }

  static Future<void> _recordDismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      _lastDismissedKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // ─── Logging ──────────────────────────────────────────────────

  static void _logUpdateInfo(AppUpdateInfo info) {
    debugPrint('''
📱 Update Info:
   - Availability: ${info.updateAvailability}
   - Immediate Allowed: ${info.immediateUpdateAllowed}
   - Flexible Allowed: ${info.flexibleUpdateAllowed}
   - Available Version: ${info.availableVersionCode}
''');
  }

  // ─── Immediate Update ─────────────────────────────────────────

  static Future<void> _showImmediateUpdateDialog(BuildContext context) async {
    if (!context.mounted) return;

    await BaseAppDialog.show(
      context,
      title: 'تحديث مطلوب',
      contentText: 'يوجد تحديث جديد للتطبيق. يرجى التحديث للاستمرار.',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _recordDismiss();
          },
          child: const Text('لاحقاً'),
        ),
        FilledButton(
          onPressed: () => _handleImmediateUpdate(context),
          child: const Text('تحديث الآن'),
        ),
      ],
    );
  }

  static Future<void> _handleImmediateUpdate(BuildContext context) async {
    Navigator.of(context).pop();

    try {
      final result = await InAppUpdate.performImmediateUpdate();

      switch (result) {
        case AppUpdateResult.success:
          debugPrint('✅ Update completed successfully');
          break;
        case AppUpdateResult.userDeniedUpdate:
          debugPrint('⚠️ User denied update');
          await _recordDismiss();
          break;
        case AppUpdateResult.inAppUpdateFailed:
          debugPrint('⚠️ In-app update failed, trying Play Store');
          await _openPlayStore();
          break;
      }
    } catch (e) {
      debugPrint('❌ Immediate update error: $e');
      await _openPlayStore();
    }
  }

  // ─── Flexible Update ──────────────────────────────────────────

  static Future<void> _showFlexibleUpdateDialog(BuildContext context) async {
    if (!context.mounted) return;

    await BaseAppDialog.show(
      context,
      title: 'تحديث متاح',
      contentText: 'يوجد تحديث جديد. هل تريد تحميله في الخلفية؟',
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _recordDismiss();
          },
          child: const Text('لاحقاً'),
        ),
        FilledButton(
          onPressed: () => _handleFlexibleUpdate(context),
          child: const Text('تحميل'),
        ),
      ],
    );
  }

  static Future<void> _handleFlexibleUpdate(BuildContext context) async {
    Navigator.of(context).pop();

    try {
      // ✅ إظهار رسالة أثناء التحميل
      if (context.mounted) {
        _showSnackBar(context, 'جاري تحميل التحديث...', Colors.blue);
      }

      await InAppUpdate.startFlexibleUpdate();

      // ✅ بعد ما يخلص التحميل
      await InAppUpdate.completeFlexibleUpdate();
      debugPrint('✅ Flexible update completed');

      if (context.mounted) {
        _showSnackBar(context, 'تم تحميل التحديث بنجاح ✅', Colors.green);
      }
    } catch (e) {
      debugPrint('❌ Flexible update failed: $e');
      if (context.mounted) {
        _showSnackBar(context, 'فشل تحميل التحديث', Colors.red);
      }
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────

  static void _showSnackBar(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<void> _openPlayStore() async {
    final url = Uri.parse(
      'https://play.google.com/store/apps/details?id=$_packageName',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('❌ Cannot launch Play Store');
      }
    } catch (e) {
      debugPrint('❌ Error launching Play Store: $e');
    }
  }

  /// 🧹 Reset للتست (استدعيها من Debug Menu)
  static Future<void> resetUpdateState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastDismissedKey);
    debugPrint('🔄 Update dismiss state reset');
  }
}
