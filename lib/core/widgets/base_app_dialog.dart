import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';

/// Base dialog providing a serene, unified Islamic design language
class BaseAppDialog extends StatelessWidget {
  const BaseAppDialog({
    this.title,
    this.titleWidget,
    this.content,
    this.contentText,
    this.actions,
    this.icon,
    this.iconColor,
    this.contentPadding,
    this.borderRadius = 20.0,
    super.key,
  }) : assert(
         content == null || contentText == null,
         'Cannot provide both content and contentText',
       );

  final String? title;
  final Widget? titleWidget;
  final Widget? content;
  final String? contentText;
  final List<Widget>? actions;
  final IconData? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    Widget? content,
    String? contentText,
    List<Widget>? actions,
    IconData? icon,
    Color? iconColor,
    EdgeInsetsGeometry? contentPadding,
    double borderRadius = 20.0,
    bool barrierDismissible = true,
  }) =>
      showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        builder: (context) => BaseAppDialog(
          title: title,
          titleWidget: titleWidget,
          content: content,
          contentText: contentText,
          actions: actions,
          icon: icon,
          iconColor: iconColor,
          contentPadding: contentPadding,
          borderRadius: borderRadius,
        ),
      );

  static Future<void> showLoading(
    BuildContext context, {
    String? message,
  }) =>
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.5),
        builder: (context) => BaseAppDialog(
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 38.r,
                  height: 38.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.r,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colors.secondary,
                    ),
                  ),
                ),
                if (message != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.typography.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveIconColor = iconColor ?? colors.secondary;

    return Dialog(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        side: BorderSide(
          color: colors.border,
          width: 0.8,
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (icon != null) ...[
              Center(
                child: Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                    color: effectiveIconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: effectiveIconColor.withValues(alpha: 0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 26.r,
                    color: effectiveIconColor,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
            ],
            if (titleWidget != null || title != null) ...[
              titleWidget ??
                  Text(
                    title!,
                    textAlign: icon != null ? TextAlign.center : TextAlign.start,
                    style: context.typography.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
              SizedBox(height: 10.h),
            ],
            if (content != null || contentText != null) ...[
              Flexible(
                child: SingleChildScrollView(
                  child: content ??
                      Text(
                        contentText!,
                        textAlign: icon != null ? TextAlign.center : TextAlign.start,
                        style: context.typography.body.copyWith(
                          color: colors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                ),
              ),
            ],
            if (actions != null && actions!.isNotEmpty) ...[
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < actions!.length; i++) ...[
                    if (i > 0) SizedBox(width: 8.w),
                    actions![i],
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Pre-styled Confirmation Dialog
class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.isDestructive = false,
    super.key,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    String? cancelLabel,
    bool isDestructive = false,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (context) => AppConfirmationDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          isDestructive: isDestructive,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return BaseAppDialog(
      icon: isDestructive ? Icons.warning_amber_rounded : Icons.help_outline_rounded,
      iconColor: isDestructive ? colors.error : colors.secondary,
      title: title,
      contentText: message,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: colors.textSecondary,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          ),
          child: Text(cancelLabel ?? l10n.cancelButton),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: isDestructive ? colors.error : colors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
