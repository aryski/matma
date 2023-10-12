import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

class FloorState extends SimulationItemState {
  FloorState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity,
      required super.radius});

  @override
  FloorState copy() {
    return FloorState(
      defColor: defColor,
      hovColor: hovColor,
      id: id,
      position: position,
      size: size,
      color: color,
      opacity: opacity,
      radius: radius,
    );
  }
}