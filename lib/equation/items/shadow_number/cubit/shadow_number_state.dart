part of 'shadow_number_cubit.dart';

class ShadowNumberState extends SimulationItemState {
  String value;
  ShadowNumberState({
    required this.value,
    required super.defColor,
    required super.hovColor,
    required super.id,
    required super.position,
    required super.size,
    required super.color,
    required super.opacity,
    required super.radius,
  });

  @override
  ShadowNumberState copy() {
    return ShadowNumberState(
      value: value,
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
