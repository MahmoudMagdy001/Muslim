// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateAppHelper {
  static const String _launchCountKey = 'app_launch_count';
  static const String _hasRatedKey = 'has_rated';

  static final InAppReview _inAppReview = InAppReview.instance;

  /// 📱 استدعِها في أول شاشة من التطبيق (مثلاً Splash أو Home)
  static Future<void> handleAppLaunch(BuildContext context) async {
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
        await _inAppReview.openStoreListing(
          appStoreId: 'com.mahmoud.muslim', // غيّرها إلى Package name بتاعك
        );
      }

      await prefs.setBool(_hasRatedKey, true);

      // إظهار SnackBar بعد التقييم
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🌟 شكراً لتقييمك!'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
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
      await _inAppReview.openStoreListing(appStoreId: 'com.mahmoud.muslim');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🌟 شكراً لتقييمك!'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error opening store listing: $e');
    }
  }
}
