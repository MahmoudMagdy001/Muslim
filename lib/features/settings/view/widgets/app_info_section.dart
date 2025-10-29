import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({required this.localizations, super.key});
  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _AppInfoTile(
        icon: Icons.info_outline,
        title: localizations.appVersion,
        subtitle: '${localizations.version} 1.0.0',
      ),
      const Divider(),
      _AppInfoTile(
        icon: Icons.privacy_tip_outlined,
        title: localizations.privacy,
        onTap: () {},
      ),
    ],
  );
}

class _AppInfoTile extends StatelessWidget {
  const _AppInfoTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.iconTheme.color),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle!, style: theme.textTheme.bodySmall),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}
