part of 'value_cubit.dart';

class ValueState extends GameItemState {
  final UniqueKey switcherKey;
  final Signs sign;
  final bool withDarkenedColor;
  final int value;

  ValueState(
      {required this.withDarkenedColor,
      required this.sign,
      required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required this.switcherKey})
      : assert(value >= 0);

  @override
  ValueState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      int? value,
      UniqueKey? switcherKey,
      bool? withDarkenedColor,
      bool? switchedIn}) {
    return ValueState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        withDarkenedColor: withDarkenedColor ?? this.withDarkenedColor,
        sign: sign,
        value: value ?? this.value,
        switcherKey: switcherKey ?? this.switcherKey);
  }
}
