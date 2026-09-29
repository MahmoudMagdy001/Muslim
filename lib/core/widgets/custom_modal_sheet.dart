import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';

/// Unified bottom sheet launcher with authentic spiritual design
Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useSafeArea = true,
  bool showDragHandle = true,
  double? initialChildSize,
  double? minChildSize,
  double? maxChildSize,
  Color? backgroundColor,
}) {
  final colors = context.colors;

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    showDragHandle: false, // We render a refined custom handle
    backgroundColor: backgroundColor ?? colors.surface,
    elevation: 8,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      side: BorderSide(
        color: colors.border,
        width: 0.8,
      ),
    ),
    builder: (modalContext) {
      final Widget content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle) ...[
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.secondary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          Flexible(child: Builder(builder: builder)),
        ],
      );

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
}
