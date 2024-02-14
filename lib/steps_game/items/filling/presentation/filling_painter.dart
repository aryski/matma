import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/filling/cubit/filling_cubit.dart';

class FillingPainter extends CustomPainter {
  final double width;
  final double stepWdt;
  final double stepHgt;
  final double radius;
  final Color color;
  final int steps;
  final double animProgress;
  final FillingFold fold;

  FillingPainter(
      {required this.width,
      required this.radius,
      required this.stepWdt,
      required this.color,
      required this.steps,
      required this.animProgress,
      required this.stepHgt,
      required this.fold});

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    bool isUp = steps > 0;

    var top = 0.0;
    var degress = 1 - animProgress;

    if (isUp) {
      var rectWidth = width - (steps.abs() - 1) * 2 * stepWdt;
      var left = stepWdt * (steps - 1);
      for (int i = 0; i < steps.abs(); i++) {
        var reducedHgt = stepHgt * (1 - animProgress);
        addRectangle(
            rectWidth,
            i == 0 && fold == FillingFold.full ? reducedHgt : stepHgt,
            path,
            left,
            degress,
            i == 0 && fold == FillingFold.full
                ? top + stepHgt * animProgress
                : top);

        left = left - stepWdt;
        top += stepHgt;
        rectWidth += stepWdt * 2;
      }
    } else {
      var rectWidth = width;
      var left = 0.0;
      for (int i = 0; i < steps.abs(); i++) {
        var reducedHgt = stepHgt * (1 - animProgress);
        addRectangle(
            rectWidth,
            i == steps.abs() - 1 && fold == FillingFold.full
                ? reducedHgt
                : stepHgt,
            path,
            left,
            degress,
            top);
        left = left + stepWdt;
        top += stepHgt;
        rectWidth -= stepWdt * 2;
      }
    }

    canvas.drawPath(path, Paint()..color = color);
  }

  void addRectangle(double rectWidth, double rectHgt, Path path, double left,
      double degress, double top) {
    var width = rectWidth * degress;
    var specialProgress = 1.0;
    if (width < stepWdt) {
      specialProgress = width / (stepWdt);
    }
    if (rectWidth > 0) {
      path.addRect(Rect.fromLTWH(
          left + (fold == FillingFold.right ? (1 - degress) * rectWidth : 0),
          animProgress == 0 ? top + rectHgt * (1 - specialProgress) : top,
          rectWidth * degress,
          animProgress == 0 ? rectHgt * specialProgress : rectHgt));
    }
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
