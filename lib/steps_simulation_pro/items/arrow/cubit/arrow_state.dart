import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_state.dart';

class ArrowState extends SimulationItemState {
  ArrowState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity});

  ArrowState copy() {
    return ArrowState(
        defColor: defColor,
        hovColor: hovColor,
        id: id,
        position: position,
        size: size,
        color: color,
        opacity: opacity);
  }
}
