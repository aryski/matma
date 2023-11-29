import 'package:flutter/material.dart';

class FillingPainter extends CustomPainter {
  final double width;
  final double height;
  final double stepWdt;
  final double stepHgt;
  final double radius;
  final Color color;
  final int steps;
  final double animProgress;

  FillingPainter(
      {required this.width,
      required this.radius,
      required this.height,
      required this.stepWdt,
      required this.color,
      required this.steps,
      required this.animProgress,
      required this.stepHgt});

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    bool isUp = steps > 0;
    //animProgress
    //0 w srodku, -1 zwiniete w lewo, 1 zwiniete w prawo
    var top = 0.0;
    var degress = 1 - animProgress.abs();
    var rectWidth = width - (steps.abs() - 1) * 2 * stepWdt;
    if (isUp) {
      var left = stepWdt * (steps - 1);
      for (int i = 0; i < steps.abs(); i++) {
        addRectangle(rectWidth, stepHgt, path, left, degress, top);

        left = left - stepWdt;
        top += stepHgt;
        rectWidth += stepWdt * 2;
      }
    } else {
      var rectWidth = width;
      var left = 0.0;
      for (int i = 0; i < steps.abs(); i++) {
        addRectangle(rectWidth, stepHgt, path, left, degress, top);

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
          animProgress <= 0 ? left : left + (1 - degress) * rectWidth,
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
