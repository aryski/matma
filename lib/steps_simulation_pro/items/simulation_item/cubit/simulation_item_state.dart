import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_state.dart';

abstract class SimulationItemState {
  UniqueKey id;
  Offset position;
  Offset size;
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

  SimulationItemState copy();
}
