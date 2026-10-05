import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim/core/theme/design_system.dart';
import 'package:muslim/core/utils/extensions.dart';

class SebhaControls extends StatelessWidget {
  const SebhaControls({
    required this.onReset,
    required this.onSetGoal,
    super.key,
  });

  final VoidCallback onReset;
  final VoidCallback onSetGoal;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = colors.isDark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: context.radius.lgBorder,
        color: isDark
            ? colors.surface
            : colors.surfaceVariant,
        border: Border.all(
          color: colors.border,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            onPressed: onReset,
            icon: Icons.refresh_rounded,
            label: context.l10n.resetTasbeh,
            colors: colors,
          ),
          Container(
            width: 1,
            height: 28.h,
            color: colors.border,
          ),
          _ControlButton(
            onPressed: onSetGoal,
            icon: Icons.flag_rounded,
            label: context.l10n.goal,
            colors: colors,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.colors,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final AppSemanticColors colors;

  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, size: 20.r, color: colors.primary),
    label: Text(label),
    style: TextButton.styleFrom(
      foregroundColor: colors.isDark ? colors.textPrimary : colors.primary,
      textStyle: context.typography.titleSmall.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: context.radius.smBorder),
    ),
  );
}
