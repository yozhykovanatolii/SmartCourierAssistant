import 'dart:ui';
import 'package:flutter/material.dart';

class DashedBorder extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double gap;
  final double dash;

  DashedBorder({
    this.strokeWidth = 2,
    this.color = Colors.grey,
    this.gap = 5,
    this.dash = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    var rectangle = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - strokeWidth, size.height - strokeWidth),
      const Radius.circular(12),
    );
    final path = Path()..addRRect(rectangle);
    final dashPath = Path();
    double distance = 0.0;
    for (PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dash),
          Offset.zero,
        );
        distance += dash + gap;
      }
      distance = 0.0;
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
