import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({required this.theme, required this.appVersion, super.key});
  final ThemeData theme;
  final String appVersion;

  Future<void> _launchEmail(BuildContext context) async {
    final l10n = context.l10n;
    final subject = Uri.encodeComponent(l10n.emailContactSubject);
    final emailLaunchUri = Uri.parse(
      'mailto:mahmodmansour2001@gmail.com?subject=$subject',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Future<void> _launchWebsite() async {
    final websiteUri = Uri.parse('https://github.com/MahmoudMagdy001');
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutUs)),
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
              l10n.muslimAppTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.aboutUsDescription,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(height: 2.1),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              l10n.connectWithUs,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _launchEmail(context),
                icon: const Icon(Icons.email_outlined),
                label: Text(
                  l10n.sendEmail,
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
                  l10n.visitWebsite,
                  style: textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${l10n.appVersion} $appVersion',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
