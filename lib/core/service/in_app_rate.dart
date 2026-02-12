// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/app_localizations.dart';

class RateAppHelper {
  static const String _launchCountKey = 'app_launch_count';
  static const String _hasRatedKey = 'has_rated';
  static const String _packageName = 'com.mahmoud.muslim';

  static final InAppReview _inAppReview = InAppReview.instance;

  /// 📱 استدعِها في أول شاشة من التطبيق (مثلاً Splash أو Home)
  static Future<void> handleAppLaunch(BuildContext context) async {
    // In-app review is only available on Android and iOS
    if (!Platform.isAndroid && !Platform.isIOS) return;

    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt(_launchCountKey) ?? 0;
    final bool hasRated = prefs.getBool(_hasRatedKey) ?? false;

    launchCount++;
    await prefs.setInt(_launchCountKey, launchCount);

    // بعد 5 مرات تشغيل، نطلب التقييم مرة واحدة فقط
    if (launchCount >= 5 && !hasRated && context.mounted) {
      await _requestReview(context, prefs);
    }
  }

  /// ⭐ يفتح شاشة التقييم داخل التطبيق أو في المتجر
  static Future<void> _requestReview(
    BuildContext context,
    SharedPreferences prefs,
  ) async {
    try {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
      } else {
        await _inAppReview.openStoreListing(appStoreId: _packageName);
      }

      await prefs.setBool(_hasRatedKey, true);

      // إظهار SnackBar بعد التقييم
      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.rateAppMessage),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error requesting review: $e');
    }
  }

  /// 🖱️ زر يدوي للتقييم (مثلاً في الإعدادات)
  static Future<void> rateNow(BuildContext context) async {
    try {
      await _inAppReview.openStoreListing(appStoreId: _packageName);

      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.rateAppMessage),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error opening store listing: $e');
    }
  }
}
