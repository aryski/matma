import 'dart:math';

import 'package:flutter/material.dart';

Path generateUpArrow(
    double radius, double width, double height, double _progress) {
  return _generateArrow(_ArrowType.up, radius, width, height);
}

Path generateDownArrow(double radius, double width, double height) {
  return _generateArrow(_ArrowType.down, radius, width, height);
}

enum _ArrowType { up, down }

Path _generateArrow(
    _ArrowType type, double radius, double width, double height) {
  Path path = Path();
  final tHeight = 3 * sqrt(3) / 6 * width;
  var xd1 = sqrt(3) * radius;
  var xd2 = sqrt(3) / 2 * radius;
  var yd = 3 / 2 * radius;

  if (type == _ArrowType.up) {
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

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(
            0.25 * width, tHeight, width * 0.5, height - tHeight + radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)));
    path = path.shift(Offset(0, -radius));
  } else if (type == _ArrowType.down) {
    path.moveTo(width * 1 / 2, height - tHeight);
    path.lineTo(width * 1 - xd1, height - tHeight);
    path.arcToPoint(Offset(width - xd2, height - tHeight + yd),
        radius: Radius.circular(radius));
    path.lineTo(width * 1 / 2 + xd2, height - yd);
    path.arcToPoint(Offset(width * 1 / 2 - xd2, height - yd),
        radius: Radius.circular(radius));
    path.lineTo(0 + xd2, height - tHeight + yd);
    path.arcToPoint(Offset(0 + xd1, height - tHeight),
        radius: Radius.circular(radius));
    path.lineTo(width * 1 / 2, height - tHeight);

    path.addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(
            0.25 * width, -radius, width * 0.5, height - tHeight + radius),
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius)));
    path = path.shift(Offset(0, radius));
  }
  path.close();
  return path;
}
