import 'package:flutter/material.dart';

class FloorPainter extends CustomPainter {
  final double width;
  final double height;
  final double radius;
  final Color color;

  FloorPainter(this.width, this.height, this.radius, this.color);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height),
        Radius.circular(radius),
      ),
    );

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool? hitTest(Offset position) {
    return path.contains(position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
