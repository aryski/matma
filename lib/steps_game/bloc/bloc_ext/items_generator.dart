part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ItemsGenerator on StepsGameBloc {
  ArrowCubit generateArrow(
      {required Offset position,
      double animationProgress = 1.0,
      AnimatedProp<Offset>? size,
      required Direction direction}) {
    return ArrowCubit(
      ArrowState(
        id: UniqueKey(),
        position: AnimatedProp.zero(value: position),
        size: size ??
            AnimatedProp.zero(
                value: const Offset(constants.arrowW, constants.arrowH)),
        opacity: AnimatedProp.zero(value: 1.0),
        direction: direction,
        // radius: constants.radius,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      double? widthSize,
      AnimatedProp<Offset>? size,
      required Direction direction}) {
    widthSize ??= constants.floorWDef;
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: AnimatedProp.zero(value: position),
        size: size ??
            AnimatedProp.zero(value: Offset(widthSize, constants.floorH)),
        opacity: AnimatedProp.zero(value: 1.0),
        // radius: constants.radius,
      ),
    );
  }
}
