import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';

class EquatorPainter extends CustomPainter {
  final EquatorState state;

  EquatorPainter(this.state);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var radius = state.radius;
    for (int i = 0; i <= 79; i++) {
      if (i.isEven) {
        print(i);
        path.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
                i * state.size.dx / 79, 0, state.size.dx / 79, state.size.dy),
            Radius.circular(radius),
          ),
        );
      }
    }

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
