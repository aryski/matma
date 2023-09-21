part of 'number_cubit.dart';

class NumberState extends SimulationItemState {
  int value;
  NumberState(
      {required this.value,
      required super.defColor,
      required super.hovColor,
      required super.id,
      required super.position,
      required super.size,
      required super.color,
      required super.opacity,
      required super.radius});

  @override
  NumberState copy() {
    return NumberState(
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
