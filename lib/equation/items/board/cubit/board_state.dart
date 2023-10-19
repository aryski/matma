part of 'board_cubit.dart';

class BoardState extends GameItemState {
  BoardState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius});

  @override
  BoardState copy() {
    return BoardState(
      id: id,
      position: position,
      size: size,
      opacity: opacity,
      radius: radius,
    );
  }
}
