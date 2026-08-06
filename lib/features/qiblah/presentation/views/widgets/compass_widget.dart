import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/widgets/custom_loading_indicator.dart';
import 'package:muslim/features/qiblah/presentation/views/widgets/arrow_painter.dart';
import 'package:muslim/features/qiblah/presentation/views/widgets/compass_background_painter.dart';

class CompassWidget extends StatelessWidget {
  const CompassWidget({
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

  static const _compassDiameterFactor = 0.78;
  static const _maxCompassDiameter = 300.0;
  static const _compassBackgroundSizeFactor = 0.97;
  static const _arrowSizeFactor = 0.45;
  static const _arrowHeightFactor = 0.85;
  // ponytail: kaaba fixed above compass, arrow rotates toward it
  static const _kaabaSize = 64.0;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final diameter = min(
      size.width * _compassDiameterFactor,
      _maxCompassDiameter,
    );
    final compassSize = Size(diameter, diameter);
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            CustomLoadingIndicator(text: context.l10n.compassLoading),
          ] else ...[
            // Fixed Kaaba image — the target the arrow points to
            _KaabaIndicator(
              isAligned: isAligned,
              primaryColor: theme.colorScheme.primary,
            ),
            SizedBox(height: 12.h),
            // Main rotating compass
            _buildMainCircle(compassSize, theme, isDark, context),
          ],
        ],
      ),
    );
  }

  Widget _buildMainCircle(Size compassSize, ThemeData theme, bool isDark, BuildContext context) {
    final primary = theme.colorScheme.primary;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: compassSize.width,
      height: compassSize.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? const Color(0xFF201A2B) : Colors.white,
        border: Border.all(
          color: isAligned ? primary : (isDark ? const Color(0xFF4C406F) : primary),
          width: isAligned ? 4.0 : 3.0,
        ),
        boxShadow: [
          if (isAligned)
            BoxShadow(
              color: primary.withAlpha(120),
              blurRadius: 28,
              spreadRadius: 6,
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 60 : 25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ClipOval(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Rotating compass background (N/S/E/W marks)
            Transform.rotate(
              angle: headingAngle,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(
                    compassSize.width * _compassBackgroundSizeFactor,
                    compassSize.height * _compassBackgroundSizeFactor,
                  ),
                  painter: CompassBackgroundPainter(theme: theme),
                ),
              ),
            ),
            // Rotating qiblah arrow — points up toward the fixed Kaaba
            Transform.rotate(
              angle: qiblahAngle,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(
                    compassSize.width * _arrowSizeFactor,
                    compassSize.height * _arrowHeightFactor,
                  ),
                  painter: ProfessionalArrowPainter(theme: theme, context: context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Fixed Kaaba indicator above compass ----------

class _KaabaIndicator extends StatelessWidget {
  const _KaabaIndicator({required this.isAligned, required this.primaryColor});

  final bool isAligned;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Kaaba image with glow ring when aligned
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(isAligned ? 3.r : 2.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor.withAlpha(isAligned ? 200 : 80),
          boxShadow: [
            if (isAligned)
              BoxShadow(
                color: primaryColor.withAlpha(140),
                blurRadius: 20,
                spreadRadius: 4,
              ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/qiblah/image_3.png',
            width: CompassWidget._kaabaSize.r,
            height: CompassWidget._kaabaSize.r,
            fit: BoxFit.cover,
            cacheWidth: 210,
            cacheHeight: 210,
          ),
        ),
      ),
      // Connector line down to compass border
      Container(
        width: 2.w,
        height: 14.h,
        color: primaryColor.withAlpha(120),
      ),
    ],
  );
}
