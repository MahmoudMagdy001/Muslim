import 'package:flutter/material.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.privacy)),
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

              // Location Info
              _LocationSection(),
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
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: context.colorScheme.shadow.withAlpha(13), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.security, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(l10n.privacyMatters, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            l10n.noPersonalData,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.privacyPrinciples, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _PrincipleItem(icon: Icons.no_accounts, title: l10n.noAccounts, description: l10n.noAccountsDesc),
        _PrincipleItem(icon: Icons.cloud_off, title: l10n.noTracking, description: l10n.noTrackingDesc),
        _PrincipleItem(icon: Icons.money_off, title: l10n.noPurchases, description: l10n.noPurchasesDesc),
      ],
    );
  }
}

class _PrincipleItem extends StatelessWidget {
  const _PrincipleItem({required this.icon, required this.title, required this.description});

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
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(8)),
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
                  style: textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
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
  const _LocationSection();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.locationDataTitle, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withAlpha((0.05 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.primary.withAlpha((0.1 * 255).toInt())),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.locationPurpose, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(l10n.locationAccessMethod, style: textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(l10n.locationStorage, style: textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(l10n.locationPrivacy, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataCollectionInfo extends StatelessWidget {
  const _DataCollectionInfo();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

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
                l10n.dataCollectionInfo,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.dataCollectionDesc,
            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.5),
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
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.localStorage, style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _StorageItem(l10n.storageQuranBookmarks),
        _StorageItem(l10n.storageSavedHadith),
        _StorageItem(l10n.storageNotificationSettings),
        _StorageItem(l10n.storageLangTheme),
        _StorageItem(l10n.storageFontSizeReciters),
        _StorageItem(l10n.storageLocationCoordinates),
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
          Text(text, style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: context.colorScheme.shadow.withAlpha(13), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.support_agent, size: 40, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(l10n.haveQuestions, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            l10n.privacyHelp,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _launchEmail(context),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.email, size: 18), const SizedBox(width: 5), Text(l10n.contactEmail)],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final l10n = context.l10n;
    final subject = Uri.encodeComponent(l10n.emailPrivacySubject);

    final emailLaunchUri = Uri.parse('mailto:mahmodmansour2001@gmail.com?subject=$subject');

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.cannotOpenEmail)));
      }
    }
  }
}

class _LastUpdate extends StatelessWidget {
  const _LastUpdate();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Center(
      child: Text(
        '${l10n.lastUpdated}: ${isArabic ? convertToArabicNumbers(_getCurrentDate()) : _getCurrentDate()}',
        textAlign: TextAlign.center,
        style: textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
      ),
    );
  }

  String _getCurrentDate() => '2025/12/23';
}
