import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

class FloorState extends GameItemState {
  final Direction direction;
  bool isLastInNumber;
  bool isLastInGame;
  FloorState(
      {this.isLastInNumber = false,
      this.isLastInGame = false,
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
      isLastInGame: isLastInGame,
      isLastInNumber: isLastInNumber,
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
