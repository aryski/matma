part of 'equator_cubit.dart';

class EquatorState extends GameItemState {
  EquatorState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius});

  @override
  EquatorState copy() {
    return EquatorState(
      id: id,
      position: position,
      size: size,
      opacity: opacity,
      radius: radius,
    );
  }
}
