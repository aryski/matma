import 'package:flutter/material.dart';

enum GameItemColor { def, hover, inactive }

abstract class GameItemState {
  UniqueKey id;
  Offset position;
  Offset size;
  GameItemColor color;
  double opacity;
  double radius;

  GameItemState(
      {required this.id,
      required this.position,
      required this.size,
      this.color = GameItemColor.def,
      required this.opacity,
      required this.radius});

  GameItemState copy();
}
