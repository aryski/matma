import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class FloorState extends GameItemState {
  bool isLast;
  FloorState(
      {this.isLast = false,
      required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required super.opacity,
      required super.radius});

  @override
  FloorState copy() {
    return FloorState(
      isLast: isLast,
      id: id,
      position: position,
      size: size,
      isHovered: isHovered,
      opacity: opacity,
      radius: radius,
    );
  }
}
