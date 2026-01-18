import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'extensions.dart';
import '../widgets/base_app_dialog.dart';

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

  @override
  Widget build(BuildContext context) => BaseAppDialog(
    titleWidget: Row(
      children: [
        Icon(Icons.location_on, color: context.colorScheme.primary),
        const SizedBox(width: 10),
        Text(isArabic ? 'استخدام الموقع' : 'Location Usage'),
      ],
    ),
    contentText: isArabic
        ? 'يقوم هذا التطبيق بجمع بيانات الموقع لتمكين حساب مواقيت الصلاة بدقة واتجاه القبلة أثناء استخدام التطبيق. يتم حفظ إحداثياتك محلياً لضمان دقة مواقيت الصلاة حتى في حالة عدم الاتصال بالإنترنت. نحن نستخدم هذه البيانات فقط لهذا الغرض ولا نشاركها مع أي طرف ثالث.'
        : 'This app collects location data to enable accurate prayer times calculation and Qibla direction while the app is in use. Your coordinates are saved locally to ensure accurate prayer times even when offline. We only use this data for this purpose and do not share it with third parties.',
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text(isArabic ? 'رفض' : 'Deny'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text(isArabic ? 'موافق' : 'Accept'),
      ),
    ],
  );
}
