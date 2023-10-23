import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

class FloorState extends GameItemState {
  final Direction direction;
  bool isLast;
  bool isLastLast;
  FloorState(
      {this.isLast = false,
      this.isLastLast = false,
      required super.id,
      required super.position,
      required super.size,
      super.isHovered,
      required this.direction,
      required super.opacity,
      required super.radius});

  @override
  FloorState copy() {
    return FloorState(
      isLastLast: isLastLast,
      isLast: isLast,
      id: id,
      position: position,
      size: size,
      isHovered: isHovered,
      direction: direction,
      opacity: opacity,
      radius: radius,
    );
  }
}
