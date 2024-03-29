part of 'equator_cubit.dart';

class EquatorState extends GameItemState {
  EquatorState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity});

  @override
  EquatorState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      double? animProgress}) {
    return EquatorState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity);
  }
}
