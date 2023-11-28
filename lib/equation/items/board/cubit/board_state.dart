part of 'board_cubit.dart';

class BoardState extends GameItemState {
  BoardState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius});

  @override
  BoardState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius}) {
    return BoardState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius);
  }
}
