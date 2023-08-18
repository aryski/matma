import 'package:flame/components.dart';
import 'package:flutter/material.dart';

final double scale = 0.5;
Color arrowColor = Colors.blueAccent;
Color flatColor = Colors.redAccent;
double ballRadius = 13 * scale;
double lineWidth = 10 * scale;
double horizontalLineLength = 50 * scale;
double lineLength = 100 * scale;

class Item extends PositionComponent {
  int maxNumber = 10;
  int index;
  Item(this.index);
}
