import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:muslim/core/theme/design_system.dart';
import 'package:muslim/core/utils/extensions.dart';
import 'package:muslim/core/utils/format_helper.dart';

class SebhaButton extends StatefulWidget {
  const SebhaButton({
    required this.onPressed,
    required this.counter,
    super.key,
    this.goal,
  });

  final VoidCallback onPressed;
  final int counter;
  final int? goal;

  @override
  State<SebhaButton> createState() => _SebhaButtonState();
}

class _SebhaButtonState extends State<SebhaButton>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;
  late Animation<double> _rippleOpacity;

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Ripple effect on tap
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutCubic),
    );
    _rippleOpacity = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // Continuous ambient glow
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    unawaited(_glowController.repeat(reverse: true));
    _glowAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  Future<void> _onTap() async {
    widget.onPressed();
    await HapticFeedback.mediumImpact();

    await _rippleController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = colors.isDark;
    final buttonSize = context.screenWidth * 0.65;
    final progressValue = widget.goal != null && widget.goal! > 0
        ? (widget.counter / widget.goal!).clamp(0.0, 1.0)
        : 0.0;

    return AnimatedBuilder(
      animation: Listenable.merge([_rippleAnimation, _glowAnimation]),
      builder: (context, child) => SizedBox(
        width: buttonSize + 40.w,
        height: buttonSize + 40.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient sacred glow
            Container(
              width: buttonSize + 16.w,
              height: buttonSize + 16.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.secondary
                        .withValues(alpha: _glowAnimation.value * 0.35),
                    blurRadius: 28,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),

            // Ripple effect
            if (_rippleController.isAnimating)
              Container(
                width: (buttonSize + 16.w) * (1 + _rippleAnimation.value * 0.25),
                height: (buttonSize + 16.h) * (1 + _rippleAnimation.value * 0.25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.secondary.withValues(
                      alpha: _rippleOpacity.value,
                    ),
                    width: 1.5,
                  ),
                ),
              ),

            // Progress ring
            SizedBox(
              width: buttonSize + 16.w,
              height: buttonSize + 16.h,
              child: CustomPaint(
                painter: _ProgressRingPainter(
                  progress: progressValue,
                  isDark: isDark,
                  primaryColor: colors.primary,
                  secondaryColor: colors.secondary,
                ),
              ),
            ),

            // Main button
            _buildMainButton(context, buttonSize, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(
    BuildContext context,
    double size,
    AppSemanticColors colors,
  ) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.primaryContainer,
              colors.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Text(
                convertToArabicNumbers(widget.counter.toString()),
                key: ValueKey(widget.counter),
                style: context.typography.counter.copyWith(
                  color: Colors.white,
                  fontSize: 44.sp,
                ),
              ),
            ),
            if (widget.goal != null) ...[
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: colors.secondary.withValues(alpha: 0.4),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  '${l10n.goal}: ${convertToArabicNumbers(widget.goal.toString())}',
                  style: context.typography.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.isDark,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double progress;
  final bool isDark;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 5.0;

    // Track
    final trackPaint = Paint()
      ..color = (isDark ? Colors.white24 : primaryColor.withValues(alpha: 0.15))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress arc with noble gold gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        transform: const GradientRotation(-pi / 2),
        colors: [
          secondaryColor,
          secondaryColor.withValues(alpha: 0.6),
          secondaryColor,
        ],
      ).createShader(rect);

    canvas.drawArc(rect, -pi / 2, 2 * pi * progress, false, progressPaint);

    // Subtle glow dot at the tip of progress
    if (progress > 0.01) {
      final angle = -pi / 2 + 2 * pi * progress;
      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final dotGlow = Paint()
        ..color = secondaryColor.withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(dotCenter, 6, dotGlow);

      final dotPaint = Paint()..color = secondaryColor;
      canvas.drawCircle(dotCenter, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      progress != oldDelegate.progress || isDark != oldDelegate.isDark;
}
