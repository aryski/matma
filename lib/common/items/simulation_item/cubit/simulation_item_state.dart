import 'package:flutter/material.dart';

abstract class SimulationItemState {
  UniqueKey id;
  Offset position;
  Offset size;
  Color color;
  Color defColor;
  Color hovColor;
  double opacity;
  double radius;

  SimulationItemState(
      {required this.defColor,
      required this.hovColor,
      required this.id,
      required this.position,
      required this.size,
      required this.color,
      required this.opacity,
      required this.radius});

  SimulationItemState copy();
}
