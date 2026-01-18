import 'package:flutter/material.dart';
import '../utils/extensions.dart';

class BaseAppDialog extends StatelessWidget {
  const BaseAppDialog({
    this.title,
    this.titleWidget,
    this.content,
    this.contentText,
    this.actions,
    this.contentPadding = const EdgeInsets.fromLTRB(24, 20, 24, 24),
    this.borderRadius = 16.0,
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
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    Widget? content,
    String? contentText,
    List<Widget>? actions,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(
      24,
      20,
      24,
      24,
    ),
    double borderRadius = 16.0,
    bool barrierDismissible = true,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => BaseAppDialog(
      title: title,
      titleWidget: titleWidget,
      content: content,
      contentText: contentText,
      actions: actions,
      contentPadding: contentPadding,
      borderRadius: borderRadius,
    ),
  );

  static Future<void> showLoading(BuildContext context, {String? message}) =>
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => BaseAppDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    backgroundColor: context.colorScheme.surface,
    surfaceTintColor: context.colorScheme.surfaceTint,
    title:
        titleWidget ??
        (title != null
            ? Text(
                title!,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              )
            : null),
    content:
        content ??
        (contentText != null
            ? Text(
                contentText!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              )
            : null),
    contentPadding: contentPadding,
    actions: actions,
    actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
  );
}
