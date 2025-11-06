import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/format_helper.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('سياسة الخصوصية')),
    body: const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _HeaderSection(),
            SizedBox(height: 24),

            // Privacy Principles
            _PrivacyPrinciples(),
            SizedBox(height: 24),

            // Local Storage
            _LocalStorageInfo(),
            SizedBox(height: 24),

            // Data Collection Info
            _DataCollectionInfo(),
            SizedBox(height: 24),

            // Contact Section
            _ContactSection(),
            SizedBox(height: 20),

            // Last Update
            _LastUpdate(),
            SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
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
            'خصوصيتك تهمنا',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'نحن لا نجمع أي بيانات شخصية على الإطلاق',
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
  const _PrivacyPrinciples();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مبادئ الخصوصية',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const _PrincipleItem(
          icon: Icons.no_accounts,
          title: 'لا يوجد حسابات',
          description: 'التطبيق لا يتطلب إنشاء حساب أو تسجيل دخول',
        ),
        const _PrincipleItem(
          icon: Icons.cloud_off,
          title: 'لا تتبع',
          description: 'لا نتابع أو نراقب استخدامك للتطبيق',
        ),
        const _PrincipleItem(
          icon: Icons.money_off,
          title: 'لا مشتريات',
          description: 'لا توجد عمليات شراء داخل التطبيق',
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
    final theme = Theme.of(context);
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

class _DataCollectionInfo extends StatelessWidget {
  const _DataCollectionInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                'معلومات جمع البيانات',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'التطبيق لا يجمع أي بيانات شخصية. كل المعلومات تبقى على جهازك فقط ولا نصل إليها بأي شكل من الأشكال.',
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
  const _LocalStorageInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التخزين المحلي',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const _StorageItem('إعدادات أوقات الصلاة'),
        const _StorageItem('تفضيلات التلاوة'),
        const _StorageItem('الأذكار المفضلة'),
        const _StorageItem('التسبيحات المحفوظة'),
        const _StorageItem('موقعك الجغرافي (محلي فقط)'),
      ],
    );
  }
}

class _StorageItem extends StatelessWidget {
  const _StorageItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
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
            'لديك استفسارات؟',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'نحن هنا لمساعدتك في أي استفسار حول الخصوصية',
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 18),
                SizedBox(width: 5),
                Text('اتصل بنا عبر البريد الإلكتروني'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final String subject = Uri.encodeComponent(
      'استفسار عن سياسة الخصوصية - تطبيق مُسَلِّم',
    );

    final Uri emailLaunchUri = Uri.parse(
      'mailto:mahmodmansour2001@gmail.com?subject=$subject',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يمكن فتح تطبيق البريد الإلكتروني')),
        );
      }
    }
  }
}

class _LastUpdate extends StatelessWidget {
  const _LastUpdate();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Center(
      child: Text(
        'آخر تحديث: ${convertToArabicNumbers(_getCurrentDate())}',
        textAlign: TextAlign.center,
        style: textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}';
  }
}
