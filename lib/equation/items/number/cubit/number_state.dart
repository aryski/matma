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
      super.color,
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
      color: color,
      opacity: opacity,
      radius: radius,
      textKey: textKey,
    );
  }
}
