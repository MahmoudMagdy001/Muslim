import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({required this.theme, required this.appVersion, super.key});
  final ThemeData theme;
  final String appVersion;

  Future<void> _launchEmail(bool isArabic) async {
    final String subject = Uri.encodeComponent(
      isArabic
          ? 'تواصل بخصوص التطبيق - أسجد و أقترب'
          : 'Contact regarding the app - Esjod & Approach',
    );
    final Uri emailLaunchUri = Uri.parse(
      'mailto:mahmodmansour2001@gmail.com?subject=$subject',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://github.com/MahmoudMagdy001');
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(title: Text(isArabic ? 'من نحن' : 'About Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/app_icon.png'),
            ),
            const SizedBox(height: 16),
            Text(
              isArabic ? 'تطبيق أسجد و أقترب' : 'Esjod & Approach App',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isArabic
                  ? 'تطبيق أسجد و أقترب هو رفيقك اليومي لتذكيرك بالصلاة وقراءة القرآن والأذكار،'
                        ' صُمم بعناية لتوفير تجربة روحانية سهلة وبسيطة في حياتك اليومية.'
                  : 'Esjod & Approach App is your daily companion for prayer reminders, Quran reading, and Azkar.'
                        ' Carefully designed to provide a simple and easy spiritual experience in your daily life.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(height: 2.1),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              isArabic ? 'تواصل معنا' : 'Connect with Us',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _launchEmail(isArabic),
                icon: const Icon(Icons.email_outlined),
                label: Text(
                  isArabic ? 'إرسال بريد إلكتروني' : 'Send an Email',
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _launchWebsite,
                icon: const Icon(Icons.public),
                label: Text(
                  isArabic ? 'زيارة موقعنا' : 'Visit our Website',
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${isArabic ? 'الإصدار' : 'Version'} $appVersion',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
