import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

enum Direction { up, down }

class ArrowState extends GameItemState {
  final Direction direction;
  final double animProgress;
  ArrowState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity,
      required this.direction,
      required super.radius,
      required this.animProgress});

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
        direction: direction,
        radius: radius,
        animProgress: animProgress);
  }
}
