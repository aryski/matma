part of 'line_cubit.dart';

class LineState extends GameItemState {
  final String text;
  LineState(
      {required super.id,
      required super.position,
      required super.size,
      required super.opacity,
      required super.radius,
      required this.text});
  @override
  LineState copyWith(
      {UniqueKey? id,
      AnimatedProp<Offset>? position,
      AnimatedProp<Offset>? size,
      bool? isHovered,
      AnimatedProp<double>? opacity,
      double? radius,
      String? text}) {
    return LineState(
        id: id ?? this.id,
        position: position ?? this.position,
        size: size ?? this.size,
        opacity: opacity ?? this.opacity,
        radius: radius ?? this.radius,
        text: text ?? this.text);
  }
}
