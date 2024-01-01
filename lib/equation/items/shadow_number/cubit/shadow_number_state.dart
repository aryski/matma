part of 'shadow_number_cubit.dart';

class ShadowNumberState extends GameItemState {
  String value;
  ShadowNumberState(
      {required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity});

  @override
  ShadowNumberState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius}) {
    return ShadowNumberState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        value: value);
  }
}
