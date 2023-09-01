import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matma/stairs_simulation_native/items/arrow/cubit/arrow_state.dart';

class ArrowPainter extends CustomPainter {
  final ArrowState state;

  ArrowPainter(this.state);

  Path path = Path();
  Path path2 = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var progress = 1.0; //TODO
    var radius = state.size.width / 15;
    final width = state.size.width;
    final height = state.size.height;
    final tHeight = 3 * sqrt(3) / 6 * state.size.width;
    var xd1 = sqrt(3) * radius;
    var xd2 = sqrt(3) / 2 * radius;
    var yd = 3 / 2 * radius;

    path.moveTo(width * 1 / 2, tHeight);
    path.lineTo(width * 1 - xd1, tHeight);
    path.arcToPoint(Offset(width - xd2, tHeight - yd),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(width * 1 / 2 + xd2, 0 + yd);
    path.arcToPoint(Offset(width * 1 / 2 - xd2, 0 + yd),
        clockwise: false, radius: Radius.circular(radius));
    path.lineTo(0 + xd2, tHeight - yd);
    path.arcToPoint(Offset(0 + xd1, tHeight),
        clockwise: false, radius: Radius.circular(radius));
    path.lineTo(width * 1 / 2, tHeight);

    if (progress > 1.50) {
      var elo = (2 - progress) * width / 4;
      path2.moveTo(width * 1 / 2, tHeight + height);
      // path.moveTo(width * 1 / 2, tHeight);
      path2.lineTo(width * 1 - xd1 - elo, tHeight + height);
      path2.arcToPoint(Offset(width - xd2 - elo, tHeight - yd + height),
          radius: Radius.circular(radius), clockwise: false);
      path2.lineTo(width * 1 / 2 + xd2 - elo, 0 + yd + height);
      path2.arcToPoint(Offset(width * 1 / 2 - xd2 + elo, 0 + yd + height),
          clockwise: false, radius: Radius.circular(radius));
      path2.lineTo(0 + xd2 + elo, tHeight - yd + height);
      path2.arcToPoint(Offset(0 + xd1 + elo, tHeight + height),
          clockwise: false, radius: Radius.circular(radius));
      path2.lineTo(width * 1 / 2, tHeight + height);
      path2.moveTo(width * 1 / 2, tHeight);
    }

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0.25 * width, tHeight, width * 0.5,
            progress * height - tHeight + radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)));
    path = path.shift(Offset(0, -radius));
    // if (progress >= 0.25) {
    path = path.shift(Offset(0, -height * progress + height));

    path2 = path2.shift(Offset(0, -radius));
    // if (progress >= 0.25) {
    path2 = path2.shift(Offset(0, -height * progress + height));

//

    // 1 2 3 4
    // 0.1
    // double radius = width / 15;
    canvas.drawPath(path, Paint()..color = state.color);
    canvas.drawPath(path2, Paint()..color = state.color);
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
