// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../widgets/base_app_dialog.dart';

class AppUpdateService {
  static Future<void> checkForUpdate(BuildContext context) async {
    if (!Platform.isAndroid) return;

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
    final l10n = AppLocalizations.of(context);
    BaseAppDialog.show(
      context,
      title: l10n.updateAvailableTitle,
      contentText: l10n.updateAvailableMessage,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.laterButton),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.pop(context);
            try {
              await InAppUpdate.performImmediateUpdate();
            } catch (_) {
              const packageName = 'com.mahmoud.muslim';
              const url =
                  'https://play.google.com/store/apps/details?id=$packageName';

              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
              }
            }
          },
          child: Text(l10n.updateNowButton),
        ),
      ],
    );
  }
}
