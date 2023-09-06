import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_state.dart';

enum Direction { up, down }

class ArrowState extends SimulationItemState {
  final Direction direction;
  ArrowState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity,
      required this.direction});

  @override
  ArrowState copy() {
    return ArrowState(
        defColor: defColor,
        hovColor: hovColor,
        id: id,
        position: position,
        size: size,
        color: color,
        opacity: opacity,
        direction: direction);
  }
}
