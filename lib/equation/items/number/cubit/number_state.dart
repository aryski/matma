part of 'number_cubit.dart';

class NumberState extends GameItemState {
  final UniqueKey textKey;
  final Signs sign;
  int value;
  NumberState(
      {required this.sign,
      required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius,
      required this.textKey})
      : assert(value >= 0);

  @override
  NumberState copy() {
    return NumberState(
      sign: sign,
      value: value,
      id: id,
      position: position,
      size: size,
      opacity: opacity,
      radius: radius,
      textKey: textKey,
    );
  }
}
