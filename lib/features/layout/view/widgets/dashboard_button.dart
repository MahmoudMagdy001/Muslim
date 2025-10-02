import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../model/dashboard_item_model.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({required this.item, required this.theme, super.key});

  final DashboardItemModel item;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => navigateWithTransition(context, item.route),
    borderRadius: BorderRadius.circular(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, color: item.color, size: 30),
        const SizedBox(height: 8),
        Text(
          item.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.titleLarge?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
