// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateAppHelper {
  static const String _launchCountKey = 'app_launch_count';
  static const String _lastReviewRequestKey = 'last_review_request';
  static const String _packageName = 'com.mahmoud.muslim';

  static const int _minLaunchesForReview = 5;
  static const int _daysBetweenRequests = 30;

  static final InAppReview _inAppReview = InAppReview.instance;

  /// 📱 استدعِها في أول شاشة من التطبيق
  static Future<void> handleAppLaunch(BuildContext context) async {
    if (!Platform.isAndroid) return;

    final prefs = await SharedPreferences.getInstance();

    if (!context.mounted) return;

    await _incrementLaunchCount(prefs);

    if (await _shouldRequestReview(prefs) && context.mounted) {
      await _requestReview(context, prefs);
    }
  }

  static Future<void> _incrementLaunchCount(SharedPreferences prefs) async {
    int launchCount = prefs.getInt(_launchCountKey) ?? 0;
    launchCount++;
    await prefs.setInt(_launchCountKey, launchCount);
    debugPrint('📱 App launch count: $launchCount');
  }

  static Future<bool> _shouldRequestReview(SharedPreferences prefs) async {
    final launchCount = prefs.getInt(_launchCountKey) ?? 0;
    final lastRequest = prefs.getInt(_lastReviewRequestKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    final daysSinceLastRequest = (now - lastRequest) ~/ (1000 * 60 * 60 * 24);

    final shouldRequest =
        launchCount >= _minLaunchesForReview &&
        daysSinceLastRequest >= _daysBetweenRequests;

    debugPrint('''
📊 Review Check:
   - Launch count: $launchCount (min: $_minLaunchesForReview)
   - Days since last: $daysSinceLastRequest (min: $_daysBetweenRequests)
   - Should request: $shouldRequest
''');

    return shouldRequest;
  }

  static Future<void> _requestReview(
    BuildContext context,
    SharedPreferences prefs,
  ) async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      debugPrint('📱 In-app review available: $isAvailable');

      if (isAvailable) {
        await _inAppReview.requestReview();
        await _recordReviewRequest(prefs);
      } else {
        // ✅ fallback للـ Play Store
        await _openPlayStore();
      }
    } on Exception catch (e) {
      debugPrint('❌ Error requesting review: $e');
      await _openPlayStore();
    }
  }

  static Future<void> _recordReviewRequest(SharedPreferences prefs) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt(_lastReviewRequestKey, now);
    // ✅ نرجع الـ launch count للصفر عشان ننتظر تاني
    await prefs.setInt(_launchCountKey, 0);
  }

  /// 🖱️ زر يدوي للتقييم (في الإعدادات مثلاً)
  static Future<void> rateNow(BuildContext context) async {
    try {
      await _openPlayStore();

      if (context.mounted) {
        _showSnackBar(context, 'تم فتح المتجر', Colors.green);
      }
    } on Exception catch (e) {
      debugPrint('❌ Error opening store: $e');
      if (context.mounted) {
        _showSnackBar(context, 'حدث خطأ', Colors.red);
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<void> _openPlayStore() async {
    await _inAppReview.openStoreListing(appStoreId: _packageName);
  }

  /// 🧹 Reset للتست (استدعيها من Debug Menu)
  static Future<void> resetReviewState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_launchCountKey);
    await prefs.remove(_lastReviewRequestKey);
    debugPrint('🔄 Review state reset');
  }

  /// 📊 جلب حالة التقييم للـ Debug
  static Future<Map<String, dynamic>> getDebugInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final lastRequest = prefs.getInt(_lastReviewRequestKey) ?? 0;

    return {
      'launchCount': prefs.getInt(_launchCountKey) ?? 0,
      'lastRequest': lastRequest != 0
          ? DateTime.fromMillisecondsSinceEpoch(lastRequest).toIso8601String()
          : 'Never',
      'isAvailable': await _inAppReview.isAvailable(),
    };
  }
}
