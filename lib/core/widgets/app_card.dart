import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';

/// Reusable AppCard designed for serene spiritual UI
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = 0,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = borderRadius != null
        ? BorderRadius.circular(borderRadius!.r)
        : context.radius.lgBorder;

    final cardContent = Padding(
      padding: padding ?? EdgeInsets.all(14.r),
      child: child,
    );

    final card = Material(
      color: backgroundColor ?? colors.surface,
      elevation: elevation,
      shadowColor: Colors.black.withValues(alpha: colors.isDark ? 0.2 : 0.04),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: borderColor ?? colors.border,
          width: 0.8,
        ),
      ),
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: cardContent,
            )
          : cardContent,
    );

    if (margin != null) {
      return Padding(padding: margin!, child: card);
    }
    return card;
  }
}
