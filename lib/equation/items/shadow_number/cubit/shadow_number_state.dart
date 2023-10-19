part of 'shadow_number_cubit.dart';

class ShadowNumberState extends GameItemState {
  String value;
  ShadowNumberState({
    required this.value,
    required super.id,
    required super.position,
    required super.size,
    super.color,
    required super.opacity,
    required super.radius,
  });

  @override
  ShadowNumberState copy() {
    return ShadowNumberState(
      value: value,
      id: id,
      position: position,
      size: size,
      color: color,
      opacity: opacity,
      radius: radius,
    );
  }
}
