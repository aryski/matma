part of 'sign_cubit.dart';

enum Signs { addition, substraction }

class SignState extends SimulationItemState {
  Signs value;
  SignState(
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
  SignState copy() {
    return SignState(
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
