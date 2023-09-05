import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation_native/items/floor/bloc/floor_bloc.dart';

class FloorPainter extends CustomPainter {
  final FloorState state;

  FloorPainter(this.state);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var radius = state.size.width / 15;
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, state.size.width, state.size.height),
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
