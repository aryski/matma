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

class FloorState extends SimulationItemState {
  FloorState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity});

  FloorState copy() {
    return FloorState(
        defColor: defColor,
        hovColor: hovColor,
        id: id,
        position: position,
        size: size,
        color: color,
        opacity: opacity);
  }
}
