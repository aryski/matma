part of 'board_cubit.dart';

class BoardState extends GameItemState {
  BoardState(
      {required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity,
      required super.radius});

  @override
  BoardState copy() {
    return BoardState(
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
