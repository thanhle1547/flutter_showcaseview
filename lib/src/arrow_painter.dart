import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final bool isUpArrow;
  final double width;
  final double height;
  final Paint _paint;

  ArrowPainter({
    this.strokeColor = Colors.black,
    this.strokeWidth = 10,
    this.paintingStyle = PaintingStyle.fill,
    this.isUpArrow = true,
    this.width = 18.0,
    this.height = 9.0,
  }) : _paint = Paint()
          ..color = strokeColor
          ..strokeWidth = strokeWidth
          ..style = paintingStyle;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(getTrianglePath(size.width, size.height), _paint);
  }

  Path getTrianglePath(double x, double y) {
    if (isUpArrow) {
      return Path()
        ..moveTo(0, y)
        ..lineTo(x / 2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);
    }
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
