import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/base_app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDisclosureDialog extends StatelessWidget {
  const LocationDisclosureDialog({required this.isArabic, super.key});

  final bool isArabic;

  static const String _disclosureKey = 'location_disclosure_accepted';

  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_disclosureKey) ?? false);
  }

  static Future<void> markAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_disclosureKey, true);
  }

  static Future<bool> showIfNeeded(BuildContext context) async {
    final should = await shouldShow();
    if (!should) return true;
    if (!context.mounted) return false;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LocationDisclosureDialog(isArabic: isArabic),
    );
    if (accepted ?? false) {
      await markAsShown();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BaseAppDialog(
      icon: Icons.location_on_rounded,
      iconColor: colors.secondary,
      title: isArabic ? 'استخدام الموقع' : 'Location Usage',
      contentText: isArabic
          ? 'يقوم هذا التطبيق بجمع بيانات الموقع لتمكين حساب مواقيت الصلاة بدقة واتجاه القبلة أثناء استخدام التطبيق. يتم حفظ إحداثياتك محلياً لضمان دقة مواقيت الصلاة حتى في حالة عدم الاتصال بالإنترنت. نحن نستخدم هذه البيانات فقط لهذا الغرض ولا نشاركها مع أي طرف ثالث.'
          : 'This app collects location data to enable accurate prayer times calculation and Qibla direction while the app is in use. Your coordinates are saved locally to ensure accurate prayer times even when offline. We only use this data for this purpose and do not share it with third parties.',
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(
            foregroundColor: colors.textSecondary,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          ),
          child: Text(isArabic ? 'رفض' : 'Deny'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(isArabic ? 'موافق' : 'Accept'),
        ),
      ],
    );
  }
}
