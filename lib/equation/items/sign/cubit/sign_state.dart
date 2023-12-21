part of 'sign_cubit.dart';

enum Signs { addition, substraction }

class SignState extends GameItemState {
  Signs value;
  UniqueKey animationKey;
  SignState(
      {required this.value,
      required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius,
      required this.animationKey});

  @override
  SignState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      UniqueKey? animationKey,
      Signs? value}) {
    return SignState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius,
        animationKey: animationKey ?? this.animationKey,
        value: value ?? this.value);
  }
}
