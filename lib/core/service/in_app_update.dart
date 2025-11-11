// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateService {
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final info = await InAppUpdate.checkForUpdate();

      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        if (context.mounted) {
          _showUpdateDialog(context);
        }
      }
    } catch (e) {
      debugPrint('❌ Error while checking for update: $e');
    }
  }

  static Future<void> _showUpdateDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'تحديث جديد متاح',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'تم إصدار نسخة جديدة من تطبيق المسلم.\nهل ترغب في التحديث الآن لتحصل على أحدث المزايا والتحسينات؟',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('لاحقًا'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await InAppUpdate.performImmediateUpdate();
              } catch (_) {
                const url =
                    'https://play.google.com/store/apps/details?id=com.mahmoud.muslim';

                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                }
              }
            },
            child: const Text(
              'تحديث الآن',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
