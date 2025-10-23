import 'dart:math';
import 'package:flutter/material.dart';
import 'arrow_painter.dart';
import 'compass_background_painter.dart';

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

  static const _compassDiameterFactor = 0.8;
  static const _maxCompassDiameter = 300.0;
  static const _compassBackgroundSizeFactor = 0.97;
  static const _arrowSizeFactor = 0.45;
  static const _arrowHeightFactor = 0.85;
  static const _fixedArrowTopPosition = -57.2;
  static const _fixedArrowSize = 100.0;
  static const _alignedTextBottomPosition = -80.0;
  static const _kaabaIconTopPosition = -100.0;
  static const _kaabaIconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diameter = min(
      size.width * _compassDiameterFactor,
      _maxCompassDiameter,
    );
    final compassSize = Size(diameter, diameter);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            // Loading indicator with message
            const Column(
              children: [
                CircularProgressIndicator(strokeWidth: 4.0),
                SizedBox(height: 16),
                Text(
                  'جاري تجهيز البوصلة...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ] else ...[
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildMainCircle(compassSize, theme, isDark),
                _buildFixedArrow(theme, isDark),
                if (isAligned) _buildAlignedText(theme, isDark),
                _buildKaabaIcon(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainCircle(Size compassSize, ThemeData theme, bool isDark) =>
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: compassSize.width,
        height: compassSize.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? Colors.grey.shade900 : Colors.white,
          border: Border.all(
            color: isAligned
                ? theme.colorScheme.primary
                : (isDark ? Colors.grey.shade700 : theme.colorScheme.surface),
            width: isAligned ? 18.0 : 14.0,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
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
            Transform.rotate(
              angle: qiblahAngle,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(
                    compassSize.width * _arrowSizeFactor,
                    compassSize.height * _arrowHeightFactor,
                  ),
                  painter: ProfessionalArrowPainter(theme: theme),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildFixedArrow(ThemeData theme, bool isDark) => Positioned(
    top: _fixedArrowTopPosition,
    child: Icon(
      Icons.arrow_drop_up,
      size: _fixedArrowSize,
      color: isAligned
          ? theme.colorScheme.primary
          : (isDark
                ? Colors.grey.shade700
                : theme.colorScheme.surface.withAlpha(230)),
    ),
  );

  Widget _buildAlignedText(ThemeData theme, bool isDark) => Positioned(
    bottom: _alignedTextBottomPosition,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(76),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white30
              : theme.colorScheme.onSurface.withAlpha(76),
        ),
      ),
      child: Text(
        'مُحاذٍ للكعبة',
        style: TextStyle(
          color: isDark ? Colors.white : theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 4)],
        ),
      ),
    ),
  );

  Widget _buildKaabaIcon() => Positioned(
    top: _kaabaIconTopPosition,
    child: DecoratedBox(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.asset(
          cacheHeight: 210,
          cacheWidth: 210,
          'assets/images/kaaba.png',
          width: _kaabaIconSize,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
