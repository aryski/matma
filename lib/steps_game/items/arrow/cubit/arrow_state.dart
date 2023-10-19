import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

enum Direction { up, down }

class ArrowState extends GameItemState {
  final Direction direction;
  final double animProgress;
  ArrowState(
      {required super.id,
      required super.position,
      required super.size,
      super.color,
      required super.opacity,
      required this.direction,
      required super.radius,
      required this.animProgress});

  @override
  ArrowState copy() {
    return ArrowState(
        id: id,
        position: position,
        size: size,
        color: color,
        opacity: opacity,
        direction: direction,
        radius: radius,
        animProgress: animProgress);
  }
}
