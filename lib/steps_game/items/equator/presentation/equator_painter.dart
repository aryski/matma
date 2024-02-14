import 'package:flutter/material.dart';

class EquatorPainter extends CustomPainter {
  final double width;
  final double height;
  final double radius;
  final Color color;

  EquatorPainter(this.width, this.height, this.radius, this.color);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    for (int i = 0; i <= 79 * 3; i++) {
      if (i.isEven) {
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(i * width / (79 * 3), 0, width / (79 * 3), height),
            Radius.circular(radius),
          ),
        );
      }
    }

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
