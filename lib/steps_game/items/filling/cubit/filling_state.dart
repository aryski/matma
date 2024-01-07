part of 'filling_cubit.dart';

enum FillingFold { left, none, right, full }

class FillingState extends GameItemState {
  final int steps;
  final double stepWdt;
  final double stepHgt;
  // final double animProgress;
  final AnimatedProp<FillingFold> fold;
  FillingState(
      {required this.stepWdt,
      required this.stepHgt,
      required this.steps,
      required super.id,
      required super.position,
      required super.size,
      required super.isHovered,
      required super.opacity,
      required this.fold});

  @override
  FillingState copyWith({
    UniqueKey? id,
    AnimatedProp<Offset>? position,
    AnimatedProp<Offset>? size,
    int? steps,
    bool? isHovered,
    AnimatedProp<double>? opacity,
    double? radius,
    AnimatedProp<FillingFold>? fold,
    double? stepWdt,
  }) {
    return FillingState(
      stepHgt: stepHgt,
      stepWdt: stepWdt ?? this.stepWdt,
      id: id ?? this.id,
      isHovered: isHovered ?? this.isHovered,
      position: position ?? this.position,
      size: size ?? this.size,
      opacity: opacity ?? this.opacity,
      steps: steps ?? this.steps,
      fold: fold ?? this.fold,
    );
  }
}
