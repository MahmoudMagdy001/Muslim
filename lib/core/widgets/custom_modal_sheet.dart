import 'package:flutter/material.dart';

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useSafeArea = true,
  bool showDragHandle = true,
  double? initialChildSize,
  double? minChildSize,
  double? maxChildSize,
}) => showModalBottomSheet<T>(
  context: context,
  isScrollControlled: isScrollControlled,
  showDragHandle: showDragHandle,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
  ),
  builder: (context) {
    final Widget content = Builder(builder: builder);

    if (initialChildSize != null ||
        minChildSize != null ||
        maxChildSize != null) {
      return DraggableScrollableSheet(
        initialChildSize: initialChildSize ?? 0.5,
        minChildSize: minChildSize ?? 0.3,
        maxChildSize: maxChildSize ?? 0.9,
        expand: false,
        builder: (context, scrollController) =>
            useSafeArea ? SafeArea(child: content) : content,
      );
    }

    return useSafeArea ? SafeArea(child: content) : content;
  },
);
