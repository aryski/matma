part of 'number_cubit.dart';

class NumberState extends GameItemState {
  final UniqueKey textKey;
  final Signs sign;
  final bool withDarkenedColor;
  final int value;
  NumberState({
    required this.withDarkenedColor,
    required this.sign,
    required this.value,
    required super.id,
    required super.position,
    required super.size,
    required super.opacity,
    required super.radius,
    required this.textKey,
  }) : assert(value >= 0);

  @override
  NumberState copy() {
    return NumberState(
      withDarkenedColor: withDarkenedColor,
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
