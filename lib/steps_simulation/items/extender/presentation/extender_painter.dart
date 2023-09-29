import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/extender/cubit/extender_cubit.dart';

class ExtenderPainter extends CustomPainter {
  final ExtenderState state;

  ExtenderPainter(this.state);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var radius = state.radius;
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, state.size.dx, state.size.dy),
        Radius.circular(radius),
      ),
    );

    canvas.drawPath(path, Paint()..color = state.color);
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
