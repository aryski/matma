part of 'sign_cubit.dart';

enum Signs { addition, substraction }

class SignState extends GameItemState {
  Signs value;
  SignState(
      {required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius});

  @override
  SignState copy() {
    return SignState(
      value: value,
      id: id,
      position: position,
      size: size,
      opacity: opacity,
      radius: radius,
    );
  }
}
