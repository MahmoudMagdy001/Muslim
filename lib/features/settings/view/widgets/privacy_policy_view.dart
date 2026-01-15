import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/format_helper.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'سياسة الخصوصية' : 'Privacy Policy'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _HeaderSection(isArabic: isArabic),
              const SizedBox(height: 24),

              // Privacy Principles
              _PrivacyPrinciples(isArabic: isArabic),
              const SizedBox(height: 24),

              // Location Info
              _LocationSection(isArabic: isArabic),
              const SizedBox(height: 24),

              // Local Storage
              _LocalStorageInfo(isArabic: isArabic),
              const SizedBox(height: 24),

              // Data Collection Info
              _DataCollectionInfo(isArabic: isArabic),
              const SizedBox(height: 24),

              // Contact Section
              _ContactSection(isArabic: isArabic),
              const SizedBox(height: 20),

              // Last Update
              _LastUpdate(isArabic: isArabic),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withAlpha(13), // 0.05 * 255 ~= 13
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.security, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            isArabic ? 'خصوصيتك تهمنا' : 'Your Privacy Matters',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'نحن لا نجمع أي بيانات شخصية على الإطلاق'
                : 'We do not collect any personal data at all',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyPrinciples extends StatelessWidget {
  const _PrivacyPrinciples({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'مبادئ الخصوصية' : 'Privacy Principles',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _PrincipleItem(
          icon: Icons.no_accounts,
          title: isArabic ? 'لا يوجد حسابات' : 'No Accounts',
          description: isArabic
              ? 'التطبيق لا يتطلب إنشاء حساب أو تسجيل دخول'
              : 'The app does not require account creation or login',
        ),
        _PrincipleItem(
          icon: Icons.cloud_off,
          title: isArabic ? 'لا تتبع' : 'No Tracking',
          description: isArabic
              ? 'لا نتابع أو نراقب استخدامك للتطبيق'
              : 'We do not track or monitor your app usage',
        ),
        _PrincipleItem(
          icon: Icons.money_off,
          title: isArabic ? 'لا مشتريات' : 'No Purchases',
          description: isArabic
              ? 'لا توجد عمليات شراء داخل التطبيق'
              : 'There are no in-app purchases',
        ),
      ],
    );
  }
}

class _PrincipleItem extends StatelessWidget {
  const _PrincipleItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'بيانات الموقع (Location)' : 'Location Data',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha((0.05 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.primary.withAlpha((0.1 * 255).toInt()),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isArabic
                    ? '• الغرض: حساب مواقيت الصلاة بدقة واتجاه القبلة.'
                    : '• Purpose: Calculating accurate prayer times and Qibla direction.',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? '• طريقة الوصول: يتم الوصول للموقع فقط أثناء استخدامك للتطبيق (Foreground) لتحديث الإحداثيات.'
                    : '• Access Method: Location is accessed only while using the app (Foreground) to update coordinates.',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? '• التخزين: يتم حفظ آخر إحداثيات معروفة محلياً على جهازك لضمان استمرارية عمل التنبيهات بدقة حتى في حالة عدم الاتصال.'
                    : '• Storage: Last known coordinates are saved locally on your device to ensure accurate alerts even offline.',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? '• الخصوصية: لا يتم إرسال بيانات موقعك لأي خادم خارجي ولا يتم مشاركتها مع أي طرف ثالث.'
                    : '• Privacy: Your location data is not sent to any external server and is not shared with third parties.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataCollectionInfo extends StatelessWidget {
  const _DataCollectionInfo({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha((0.03 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                isArabic ? 'معلومات جمع البيانات' : 'Data Collection Info',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isArabic
                ? 'التطبيق لا يجمع أي بيانات شخصية. كل المعلومات تبقى على جهازك فقط ولا نصل إليها بأي شكل من الأشكال.'
                : 'The app does not collect any personal data. All information remains on your device only and we do not access it in any way.',
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalStorageInfo extends StatelessWidget {
  const _LocalStorageInfo({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'التخزين المحلي' : 'Local Storage',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _StorageItem(
          isArabic ? 'الإشارات المرجعية لآيات القرآن' : 'Quran Ayah Bookmarks',
        ),
        _StorageItem(isArabic ? 'الأحاديث المحفوظة' : 'Saved Hadiths'),
        _StorageItem(
          isArabic ? 'إعدادات التنبيهات والأذان' : 'Notification Settings',
        ),
        _StorageItem(
          isArabic ? 'تفضيلات اللغة والمظهر' : 'Language & Theme Preferences',
        ),
        _StorageItem(
          isArabic ? 'حجم الخط والقراء المفضلين' : 'Font Size & Reciters',
        ),
        _StorageItem(
          isArabic
              ? 'إحداثيات الموقع (محلياً فقط)'
              : 'Location Coordinates (Local only)',
        ),
      ],
    );
  }
}

class _StorageItem extends StatelessWidget {
  const _StorageItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.support_agent, size: 40, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            isArabic ? 'لديك استفسارات؟' : 'Have Questions?',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'نحن هنا لمساعدتك في أي استفسار حول الخصوصية'
                : 'We are here to help with any privacy questions',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _launchEmail(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email, size: 18),
                const SizedBox(width: 5),
                Text(
                  isArabic
                      ? 'اتصل بنا عبر البريد الإلكتروني'
                      : 'Contact Us via Email',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final String subject = Uri.encodeComponent(
      isArabic
          ? 'استفسار عن سياسة الخصوصية - مُسَلِّم'
          : 'Privacy Policy Inquiry - Muslim',
    );

    final Uri emailLaunchUri = Uri.parse(
      'mailto:mahmodmansour2001@gmail.com?subject=$subject',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isArabic
                  ? 'لا يمكن فتح تطبيق البريد الإلكتروني'
                  : 'Cannot open email app',
            ),
          ),
        );
      }
    }
  }
}

class _LastUpdate extends StatelessWidget {
  const _LastUpdate({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Center(
      child: Text(
        '${isArabic ? 'آخر تحديث' : 'Last Updated'}: ${isArabic ? convertToArabicNumbers(_getCurrentDate()) : _getCurrentDate()}',
        textAlign: TextAlign.center,
        style: textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  String _getCurrentDate() => '2025/12/23';
}
