// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/base_app_dialog.dart';

class AppUpdateService {
  static const String _packageName = 'com.mahmoud.muslim';
  static const String _lastDismissedKey = 'update_last_dismissed';
  static const int _daysBetweenPrompts = 3;

  static final Upgrader _upgrader = Upgrader(debugLogging: true);

  /// Check for updates and show dialog if available
  static Future<void> checkForUpdate(BuildContext context) async {
    if (!context.mounted) return;

    try {
      // Initialize upgrader
      await _upgrader.initialize();

      // Check if update is available via upgrader
      final shouldDisplay = _upgrader.shouldDisplayUpgrade();

      if (!shouldDisplay || !context.mounted) {
        debugPrint('No update available or context not mounted');
        return;
      }

      // Check cooldown manually for additional control
      if (await _isDismissCooldownActive()) {
        debugPrint('Update prompt cooldown active, skipping');
        return;
      }

      if (!context.mounted) return;
      await _showFlexibleUpdateDialog(context);
    } catch (e, stackTrace) {
      debugPrint('Error checking for update: $e');
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

    debugPrint('Update cooldown: $daysSince days since last dismiss');
    return daysSince < _daysBetweenPrompts;
  }

  static Future<void> _recordDismiss() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      _lastDismissedKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // ─── Update Dialog ──────────────────────────────────────────

  static Future<void> _showFlexibleUpdateDialog(BuildContext context) async {
    if (!context.mounted) return;

    final storeUrl = _getStoreUrl();

    await BaseAppDialog.show(
      context,
      title: 'تحديث متاح',
      contentText:
          'يوجد تحديث جديد (الإصدار ${_upgrader.currentAppStoreVersion}). هل تريد التحديث الآن؟',
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _recordDismiss();
          },
          child: const Text('لاحقاً'),
        ),
        FilledButton(
          onPressed: () => _openStore(context, storeUrl),
          child: const Text('تحديث الآن'),
        ),
      ],
    );
  }

  // ─── Store Navigation ─────────────────────────────────────────

  static String _getStoreUrl() {
    if (Platform.isIOS) {
      return 'https://apps.apple.com/app/$_packageName';
    }
    return 'https://play.google.com/store/apps/details?id=$_packageName';
  }

  static Future<void> _openStore(BuildContext context, String url) async {
    Navigator.of(context).pop();

    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Cannot launch store URL');
      }
    } catch (e) {
      debugPrint('Error launching store: $e');
    }
  }

  /// Reset for testing (call from Debug Menu)
  static Future<void> resetUpdateState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastDismissedKey);
    _upgrader.saveLastAlerted();
    debugPrint('Update dismiss state reset');
  }
}
