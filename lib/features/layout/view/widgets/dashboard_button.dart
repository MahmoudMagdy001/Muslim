import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/dashboard_item_model.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({required this.item, super.key});

  final DashboardItemModel item;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => navigateWithTransition(context, item.route),
    borderRadius: .circular(20.toR),
    child: Container(
      decoration: BoxDecoration(
        color: context.theme.brightness == Brightness.dark
            ? item.darkColor
            : item.color,
        borderRadius: .circular(20.toR),
      ),
      padding: .all(12.toW),
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            item.label,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: .bold,
              color: context.theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
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
