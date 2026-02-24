import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/format_helper.dart';

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
      duration: const Duration(milliseconds: 600),
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
    _rippleOpacity = Tween<double>(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    // Continuous ambient glow
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  Future<void> _onTap() async {
    widget.onPressed();
    HapticFeedback.mediumImpact();

    _rippleController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final buttonSize = context.screenWidth * 0.65;
    final progressValue = widget.goal != null && widget.goal! > 0
        ? (widget.counter / widget.goal!).clamp(0.0, 1.0)
        : 0.0;

    return AnimatedBuilder(
      animation: Listenable.merge([_rippleAnimation, _glowAnimation]),
      builder: (context, child) => SizedBox(
        width: buttonSize + 40,
        height: buttonSize + 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient glow
            Container(
              width: buttonSize + 20,
              height: buttonSize + 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDark
                                ? context.colorScheme.secondary
                                : context.colorScheme.primary)
                            .withAlpha((_glowAnimation.value * 80).toInt()),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),

            // Ripple effect
            if (_rippleController.isAnimating)
              Container(
                width: (buttonSize + 20) * (1 + _rippleAnimation.value * 0.3),
                height: (buttonSize + 20) * (1 + _rippleAnimation.value * 0.3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        (isDark
                                ? context.colorScheme.secondary
                                : context.colorScheme.primary)
                            .withAlpha((_rippleOpacity.value * 255).toInt()),
                    width: 2,
                  ),
                ),
              ),

            // Progress ring
            SizedBox(
              width: buttonSize + 16,
              height: buttonSize + 16,
              child: CustomPaint(
                painter: _ProgressRingPainter(
                  progress: progressValue,
                  isDark: isDark,
                  primaryColor: context.colorScheme.primary,
                  secondaryColor: context.colorScheme.secondary,
                ),
              ),
            ),

            // Main button
            _buildMainButton(context, buttonSize, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context, double size, bool isDark) {
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
            colors: isDark
                ? [const Color(0xFF3D2E6B), const Color(0xFF251A45)]
                : [const Color(0xFF7C6FB3), context.colorScheme.primary],
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.primary.withAlpha(80),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Text(
                convertToArabicNumbers(widget.counter.toString()),
                key: ValueKey(widget.counter),
                style: context.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            if (widget.goal != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${l10n.goal}: ${convertToArabicNumbers(widget.goal.toString())}',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: 13,
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
      ..color = (isDark ? Colors.white : primaryColor).withAlpha(30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress arc with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        transform: const GradientRotation(-pi / 2),
        colors: isDark
            ? [
                secondaryColor,
                secondaryColor.withAlpha(180),
                const Color(0xFF7C6FB3),
              ]
            : [primaryColor, const Color(0xFF7C6FB3), secondaryColor],
      ).createShader(rect);

    canvas.drawArc(rect, -pi / 2, 2 * pi * progress, false, progressPaint);

    // Glow dot at the end of the progress
    if (progress > 0.01) {
      final angle = -pi / 2 + 2 * pi * progress;
      final dotCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final dotGlow = Paint()
        ..color = (isDark ? secondaryColor : secondaryColor).withAlpha(100)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(dotCenter, 6, dotGlow);

      final dotPaint = Paint()
        ..color = isDark ? secondaryColor : secondaryColor;
      canvas.drawCircle(dotCenter, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      progress != oldDelegate.progress || isDark != oldDelegate.isDark;
}
