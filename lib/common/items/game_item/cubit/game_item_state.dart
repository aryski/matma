import 'package:flutter/material.dart';

abstract class GameItemState {
  UniqueKey id;
  Offset position;
  Offset size;
  Color color;
  Color defColor;
  Color hovColor;
  double opacity;
  double radius;

  GameItemState(
      {required this.defColor,
      required this.hovColor,
      required this.id,
      required this.position,
      required this.size,
      required this.color,
      required this.opacity,
      required this.radius});

  GameItemState copy();
}
