part of 'sign_cubit.dart';

enum Signs { addition, substraction }

class SignState extends GameItemState {
  Signs value;
  UniqueKey switcherKey;
  SignState(
      {required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required this.switcherKey});

  @override
  SignState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      UniqueKey? switcherKey,
      Signs? value}) {
    return SignState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        switcherKey: switcherKey ?? this.switcherKey,
        value: value ?? this.value);
  }
}
