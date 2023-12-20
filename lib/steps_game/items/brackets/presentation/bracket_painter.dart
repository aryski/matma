import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/bloc/constants.dart' as constants;

class BracketPainter extends CustomPainter {
  final double width;
  final double height;
  final double heightOffset;
  final double radius;
  final Color color;
  final Direction direction;

  BracketPainter(this.width, this.height, this.radius, this.color,
      this.direction, this.heightOffset);

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var unit = constants.arrowH * 400 / 2;
    var stroke = constants.arrowH * 400 / 4;
    var path = Path();
    var height = constants.arrowH * 400;
    // if (Random.secure().nextBool()) {
    print(width);
    print(unit);
    if (width < 3 * unit) {
      unit = height / 3;
      path.arcToPoint(Offset(width / 2, width / 2),
          radius: Radius.circular(width / 2), clockwise: false);
      path.lineTo(width / 2, width / 2 - stroke);

      path.arcToPoint(Offset(stroke, 0),
          radius: Radius.circular(width / 2 - stroke), clockwise: true);
    } else if (width < 5 * unit) {
      unit = height / 3;
      path.arcToPoint(Offset(2 * unit, 2 * unit),
          radius: Radius.circular(2 * unit), clockwise: false);
      path.lineTo(width / 2, 2 * unit);
      path.lineTo(width / 2, 2 * unit - stroke);
      path.lineTo(2 * unit, 2 * unit - stroke);
      path.arcToPoint(Offset(stroke, 0),
          radius: Radius.circular(2 * unit - stroke), clockwise: true);
    } else {
      unit = height / 3;
      path.arcToPoint(Offset(2 * unit, 2 * unit),
          radius: Radius.circular(2 * unit), clockwise: false);
      path.lineTo(width / 2 - unit, 2 * unit);
      path.arcToPoint(Offset(width / 2 - stroke / 2, 3 * unit),
          radius: Radius.circular(unit), clockwise: true);
      path.lineTo(width / 2, 3 * unit);
      path.lineTo(width / 2, 3 * unit - stroke);
      path.arcToPoint(Offset(width / 2 - unit, 2 * unit - stroke),
          radius: Radius.circular(unit), clockwise: false);
      path.lineTo(2 * unit, 2 * unit - stroke);
      path.arcToPoint(Offset(stroke, 0),
          radius: Radius.circular(2 * unit - stroke), clockwise: true);

      // path.moveTo(0, 0);
      // var lineHgt = (this.height - height) / 50;
      // for (int i = 0; i <= 100; i++) {
      //   if (i.isOdd) {
      //     if (((i + 1) * lineHgt) < this.height) {
      //       path.addRRect(
      //         RRect.fromRectAndRadius(
      //           Rect.fromLTWH(0, i * -lineHgt, stroke, lineHgt),
      //           Radius.circular(stroke / 5),
      //         ),
      //       );
      //     }
      //   }
      // }
      // path.lineTo(0, -this.height + height);
      // path.lineTo(stroke, -this.height + height);
      // path.lineTo(stroke, 0);
      // path.lineTo(0, 0);
    }
    // } else {
    // unit = height / 2;
    // path.arcToPoint(Offset(unit, unit),
    //     radius: Radius.circular(unit), clockwise: false);
    // path.lineTo(width / 2 - unit, unit);
    // path.arcToPoint(Offset(width / 2 - stroke / 2, 2 * unit),
    //     radius: Radius.circular(unit), clockwise: true);
    // path.lineTo(width / 2, 2 * unit);
    // path.lineTo(width / 2, 2 * unit - stroke);
    // path.arcToPoint(Offset(width / 2 - unit, unit - stroke),
    //     radius: Radius.circular(unit), clockwise: false);
    // path.lineTo(unit, unit - stroke);
    // path.arcToPoint(Offset(stroke, 0),
    //     radius: Radius.circular(unit - stroke), clockwise: true);
    // }

    if (true || direction == Direction.down) {
      path = path.transform((Matrix4.identity()..rotateX(pi)).storage);
      path = path.shift(Offset(0, height));
    }

    canvas.drawPath(path, Paint()..color = color);

    path = path.transform((Matrix4.identity()..rotateY(pi)).storage);
    path = path.shift(Offset(width, 0));

    canvas.drawPath(path, Paint()..color = color);
    var lineHgt = stroke * 1.6 * 2;
    var spaceHgt = stroke * 2;
    //lines
    path = Path();
    var dx = 3 * unit;
    for (int i = 0; i <= 100; i++) {
      if (i.isOdd) {
        if (dx < this.height) {
          path.addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                  direction == Direction.up ? 0 : width - stroke,
                  dx,
                  stroke,
                  dx + lineHgt > this.height ? this.height - dx : lineHgt),
              Radius.circular(stroke / 5),
            ),
          );
        }
        if (dx < this.height * heightOffset) {
          if (dx + lineHgt > this.height * heightOffset) {}
          path.addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                  direction == Direction.down ? 0 : width - stroke,
                  dx,
                  stroke,
                  dx + lineHgt > this.height * heightOffset
                      ? this.height * heightOffset - dx
                      : lineHgt),
              Radius.circular(stroke / 5),
            ),
          );
        }
        dx += lineHgt;
      } else {
        dx += spaceHgt;
      }
    }
    canvas.drawPath(path, Paint()..color = color.withOpacity(0.1));
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
