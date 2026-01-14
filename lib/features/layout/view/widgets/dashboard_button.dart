import 'package:flutter/material.dart';

import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/dashboard_item_model.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({required this.item, required this.theme, super.key});

  final DashboardItemModel item;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => navigateWithTransition(context, item.route),
    borderRadius: .circular(20.toR),
    child: Container(
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: .circular(20.toR),
      ),
      padding: .all(12.toW),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            item.label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: .bold,
              color: Colors.black87,
              fontSize: 18.toSp,
            ),
            textAlign: .center,
          ),
          Expanded(
            child: Center(
              child: Image.asset(item.image, fit: BoxFit.cover, height: 80.toH),
            ),
          ),
        ],
      ),
    ),
  );
}
