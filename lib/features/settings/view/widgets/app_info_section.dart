import 'package:flutter/material.dart';

import 'section_card.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) => SectionCard(
    title: 'معلومات التطبيق',
    child: Column(
      children: [
        const _AppInfoTile(
          icon: Icons.info_outline,
          title: 'إصدار التطبيق',
          subtitle: 'الإصدار 1.0.0',
        ),
        const Divider(),
        _AppInfoTile(
          icon: Icons.privacy_tip_outlined,
          title: 'سياسة الخصوصية',
          onTap: () {},
        ),
      ],
    ),
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
