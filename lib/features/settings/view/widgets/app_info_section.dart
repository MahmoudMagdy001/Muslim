import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'about_us.dart';
import 'privacy_policy_view.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({
    required this.localizations,
    required this.theme,
    required this.appVersion,
    super.key,
  });

  final AppLocalizations localizations;
  final ThemeData theme;
  final String appVersion;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _AppInfoTile(
        icon: Icons.info_outline,
        title: localizations.appVersion,
        subtitle: '${localizations.version} $appVersion',
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
      const Divider(thickness: 0.05),
      _AppInfoTile(
        icon: Icons.person_rounded,
        title: 'من نحن',
        theme: theme,
        onTap: () => navigateWithTransition(
          context,
          AboutUsView(theme: theme, appVersion: appVersion),
          type: TransitionType.fade,
        ),
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
