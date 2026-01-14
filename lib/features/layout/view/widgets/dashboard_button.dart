import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/navigation_helper.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../model/dashboard_item_model.dart';

class DashboardButton extends StatelessWidget {
  const DashboardButton({required this.item, super.key});

  final DashboardItemModel item;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.9, end: 1.0),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutBack,
    builder: (context, scale, child) =>
        Transform.scale(scale: scale, child: child),
    child: InkWell(
      onTap: () => navigateWithTransition(context, item.route),
      borderRadius: BorderRadius.circular(20.toR),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.brightness == Brightness.dark
              ? item.darkColor
              : item.color,
          borderRadius: BorderRadius.circular(20.toR),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.toW),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.label,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.theme.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                  height: 80.toH,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
