import 'package:flame/components.dart';
import 'package:flutter/material.dart';

Color arrowColor = Colors.blueAccent;
Color flatColor = Colors.redAccent;

class Item extends PositionComponent {
  int maxNumber = 10;
  int index;
  double unit;
  double horizUnit;
  Item(this.index, this.unit, this.horizUnit);
}
