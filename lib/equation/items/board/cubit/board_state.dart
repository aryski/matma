part of 'board_cubit.dart';

class BoardState extends GameItemState {
  BoardState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius,
      super.color});

  @override
  BoardState copy() {
    return BoardState(
      id: id,
      position: position,
      size: size,
      color: color,
      opacity: opacity,
      radius: radius,
    );
  }
}
