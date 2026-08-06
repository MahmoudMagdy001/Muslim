import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/qiblah/presentation/views/widgets/compass_widget.dart';

class QiblahSuccessWidget extends StatelessWidget {
  const QiblahSuccessWidget({
    required this.headingAngle,
    required this.qiblahAngle,
    required this.isAligned,
    required this.isLoading,
    super.key,
  });

  final double headingAngle;
  final double qiblahAngle;
  final bool isAligned;
  final bool isLoading;


  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      children: [
        SizedBox(height: 16.h),
        _QiblahHeader(isLoading: isLoading),
        SizedBox(height: 8.h),
        Expanded(
          child: CompassWidget(
            headingAngle: headingAngle,
            qiblahAngle: qiblahAngle,
            isAligned: isAligned,
            isLoading: isLoading,
          ),
        ),
        if (!isLoading) ...[
          SizedBox(height: 12.h),
          _AlignedBanner(isAligned: isAligned),
        ],
        SizedBox(height: 24.h),
      ],
    ),
  );
}

// ---------- Header ----------

class _QiblahHeader extends StatelessWidget {
  const _QiblahHeader({required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const SizedBox.shrink();
    final cs = context.colorScheme;
    return Text(
      context.l10n.qiblahSubtitle,
      style: TextStyle(
        color: cs.onSurface.withAlpha(153),
        fontSize: 13.sp,
        letterSpacing: 0.4,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// ---------- Aligned Banner ----------

class _AlignedBanner extends StatelessWidget {
  const _AlignedBanner({required this.isAligned});
  final bool isAligned;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: isAligned
          ? Container(
              key: const ValueKey('aligned'),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withAlpha(200),
                    cs.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withAlpha(100),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.white, size: 18.r),
                  SizedBox(width: 8.w),
                  Text(
                    context.l10n.salahDirection,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 4)],
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              key: const ValueKey('not_aligned'),
              height: 40.h, // ponytail: preserve layout height when hidden
            ),
    );
  }
}
