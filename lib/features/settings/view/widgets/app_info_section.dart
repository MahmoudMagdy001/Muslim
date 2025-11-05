import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'privacy_policy_view.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({
    required this.localizations,
    required this.theme,
    super.key,
  });
  final AppLocalizations localizations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _AppInfoTile(
        icon: Icons.info_outline,
        title: localizations.appVersion,
        subtitle: '${localizations.version} 1.0.0',
        theme: theme,
      ),
      const Divider(),
      _AppInfoTile(
        icon: Icons.privacy_tip_outlined,
        title: localizations.privacy,
        onTap: () {
          navigateWithTransition(
            context,
            const PrivacyPolicyView(),
            type: TransitionType.fade,
          );
        },
        theme: theme,
      ),
    ],
  );
}

class _AppInfoTile extends StatelessWidget {
  const _AppInfoTile({
    required this.icon,
    required this.title,
    required this.theme,
    this.subtitle,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => ListTile(
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
