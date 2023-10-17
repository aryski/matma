import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

class ArrowPainter extends CustomPainter {
  final double width;
  final double height;
  final double radius;
  final Color color;
  final Direction direction;
  final double animationProgress;
  ArrowPainter(this.width, this.height, this.radius, this.color, this.direction,
      this.animationProgress);

  Path path = Path();
  Path path2 = Path();

  @override
  void paint(Canvas canvas, Size size) {
    path = Path();
    var equilateralHeight = 3 * sqrt(3) / 6 * width;
    final tHeight = height < equilateralHeight ? height : equilateralHeight;
    var progress = animationProgress;

    path.addPath(
        generateTriangle(width, tHeight, radius, progress), Offset.zero);

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(
            0.25 * width, tHeight, width * 0.5, height - tHeight + radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)));
    path = path.shift(Offset(0, -radius));
    if (direction == Direction.down) {
      path = path.transform((Matrix4.identity()..rotateX(pi)).storage);
      path = path.shift(Offset(0, height));
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

Path generateTriangle(
    double width, double tHeight, double radius, double progress) {
  var rectOffset = 1 / 4 * width * (1 - progress);
  var xd1 = sqrt(3) * radius * progress;
  var xd2 = sqrt(3) / 2 * radius * progress;
  var yd = 3 / 2 * radius * progress;
  var rectOffsetVertical = radius * (1 - progress);
  if (progress > 0) {
    radius = radius * 1 / progress;
  } else {
    radius = 10000;
  }

  Path path = Path();
  path.moveTo(width * 1 / 2, tHeight);
  path.lineTo(width * 1 - xd1 - rectOffset, 1 * tHeight);
  path.arcToPoint(Offset(width - xd2 - rectOffset, tHeight - yd),
      radius: Radius.circular(radius), clockwise: false);
  path.lineTo(width * 1 / 2 + xd2 + rectOffset, 0 + yd + rectOffsetVertical);
  path.arcToPoint(
      Offset(width * 1 / 2 - xd2 - rectOffset, 0 + yd + rectOffsetVertical),
      clockwise: false,
      radius: Radius.circular(radius));
  path.lineTo(0 + xd2 + rectOffset, tHeight - yd);
  path.arcToPoint(Offset(0 + xd1 + rectOffset, tHeight),
      clockwise: false, radius: Radius.circular(radius));
  path.lineTo(width * 1 / 2, tHeight);
  return path;
}
