import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/features/qiblah/presentation/cubit/qiblah_cubit.dart';

class QiblahErrorWidget extends StatelessWidget {
  const QiblahErrorWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final isDark = context.theme.brightness == Brightness.dark;
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with background
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.errorContainer.withAlpha(isDark ? 60 : 40),
              ),
              child: Icon(
                Icons.location_off_rounded,
                size: 40.r,
                color: cs.error,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              l10n.errorMain,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: cs.onSurface.withAlpha(153),
                height: 1.5,
              ),
            ),
            SizedBox(height: 28.h),
            FilledButton.icon(
              onPressed: () => context.read<QiblahCubit>().init(),
              icon: Icon(Icons.refresh_rounded, size: 18.r),
              label: Text(l10n.retry),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
