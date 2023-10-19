part of 'equator_cubit.dart';

class EquatorState extends GameItemState {
  EquatorState(
      {required super.id,
      required super.position,
      required super.size,
      super.color,
      required super.opacity,
      required super.radius});

  @override
  EquatorState copy() {
    return EquatorState(
      id: id,
      position: position,
      size: size,
      color: color,
      opacity: opacity,
      radius: radius,
    );
  }
}
