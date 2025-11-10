import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({required this.theme, required this.appVersion, super.key});
  final ThemeData theme;
  final String appVersion;

  Future<void> _launchEmail() async {
    final String subject = Uri.encodeComponent(
      'تواصل بخصوص التطبيق - مُسَلِّم',
    );
    final Uri emailLaunchUri = Uri.parse(
      'mailto:mahmodmansour2001@gmail.com?subject=$subject',
    );
    await launchUrl(emailLaunchUri);
  }

  Future<void> _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://github.com/MahmoudMagdy001');
    await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('من نحن')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/muslim_logo.png'),
            ),
            const SizedBox(height: 16),
            Text(
              'تطبيق مُسَلِّم',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'تطبيق مُسَلِّم هو رفيقك اليومي لتذكيرك بالصلاة وقراءة القرآن والأذكار،'
              ' صُمم بعناية لتوفير تجربة روحانية سهلة وبسيطة في حياتك اليومية.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(height: 2.1),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'تواصل معنا',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _launchEmail,
                icon: const Icon(Icons.email_outlined),
                label: Text(
                  'إرسال بريد إلكتروني',
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _launchWebsite,
                icon: const Icon(Icons.public),
                label: Text(
                  'زيارة موقعنا',
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'الإصدار $appVersion',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
