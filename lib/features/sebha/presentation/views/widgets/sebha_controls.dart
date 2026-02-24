import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/extensions.dart';

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
    final isDark = context.theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? Colors.white.withAlpha(10)
            : AppColors.primary.withAlpha(10),
        border: Border.all(
          color: isDark
              ? Colors.white.withAlpha(15)
              : AppColors.primary.withAlpha(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            onPressed: onReset,
            icon: Icons.refresh_rounded,
            label: context.l10n.resetTasbeh,
            isDark: isDark,
          ),
          Container(
            width: 1,
            height: 28,
            color: isDark
                ? Colors.white.withAlpha(20)
                : AppColors.primary.withAlpha(30),
          ),
          _ControlButton(
            onPressed: onSetGoal,
            icon: Icons.flag_rounded,
            label: context.l10n.goal,
            isDark: isDark,
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
    required this.isDark,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, size: 20),
    label: Text(label),
    style: TextButton.styleFrom(
      foregroundColor: isDark ? Colors.white70 : AppColors.primary,
      textStyle: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
