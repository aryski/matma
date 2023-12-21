part of 'value_cubit.dart';

class ValueState extends GameItemState {
  final UniqueKey textKey;
  final Signs sign;
  final bool withDarkenedColor;
  final int value;
  ValueState({
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
  ValueState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      int? value,
      UniqueKey? textKey,
      bool? withDarkenedColor}) {
    return ValueState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius,
        withDarkenedColor: withDarkenedColor ?? this.withDarkenedColor,
        sign: sign,
        value: value ?? this.value,
        textKey: textKey ?? this.textKey);
  }
}
