import 'package:flutter/material.dart';

/// Draws an authentic, delicate Islamic ornamental frame for Quran pages
class MushafFramePainter extends CustomPainter {
  const MushafFramePainter({
    required this.frameColor,
    this.innerBorder = true,
  });

  final Color frameColor;
  final bool innerBorder;

  @override
  void paint(Canvas canvas, Size size) {
    final outerPaint = Paint()
      ..color = frameColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final innerPaint = Paint()
      ..color = frameColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final accentPaint = Paint()
      ..color = frameColor.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const outerMargin = 4.0;
    final outerRect = Rect.fromLTWH(
      outerMargin,
      outerMargin,
      size.width - (outerMargin * 2),
      size.height - (outerMargin * 2),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(outerRect, const Radius.circular(8)),
      outerPaint,
    );

    if (innerBorder) {
      const innerMargin = 9.0;
      final innerRect = Rect.fromLTWH(
        innerMargin,
        innerMargin,
        size.width - (innerMargin * 2),
        size.height - (innerMargin * 2),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(innerRect, const Radius.circular(5)),
        innerPaint,
      );

      // Corner geometric Islamic motifs
      _drawCornerOrnament(canvas, accentPaint, innerMargin, innerMargin, 1, 1);
      _drawCornerOrnament(canvas, accentPaint, size.width - innerMargin, innerMargin, -1, 1);
      _drawCornerOrnament(canvas, accentPaint, innerMargin, size.height - innerMargin, 1, -1);
      _drawCornerOrnament(canvas, accentPaint, size.width - innerMargin, size.height - innerMargin, -1, -1);
    }
  }

  void _drawCornerOrnament(
    Canvas canvas,
    Paint paint,
    double x,
    double y,
    double dirX,
    double dirY,
  ) {
    const size = 10.0;
    final path = Path()
      ..moveTo(x + (dirX * size), y)
      ..lineTo(x, y)
      ..lineTo(x, y + (dirY * size))
      ..moveTo(x + (dirX * 3), y + (dirY * 3))
      ..lineTo(x + (dirX * 8), y + (dirY * 8));

    canvas.drawPath(path, paint);

    final dotPaint = Paint()
      ..color = paint.color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x + (dirX * 5), y + (dirY * 5)), 1.2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant MushafFramePainter oldDelegate) =>
      oldDelegate.frameColor != frameColor ||
      oldDelegate.innerBorder != innerBorder;
}
