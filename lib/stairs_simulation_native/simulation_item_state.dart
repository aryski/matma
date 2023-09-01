import 'package:flutter/material.dart';

class SimulationItemState {
  UniqueKey id;
  Offset position;
  Size size;
  Color color;
  Color defColor;
  Color hovColor;
  double opacity;

  SimulationItemState(
      {required this.defColor,
      required this.hovColor,
      required this.id,
      required this.position,
      required this.size,
      required this.color,
      required this.opacity});
}
