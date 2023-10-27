import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

extension ItemsGenerator on StepsGameBloc {
  ArrowCubit generateArrow(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0,
      Offset? size,
      required Direction direction}) {
    if (direction == Direction.up) {
      return __generateArrowUp(
          position: position,
          delta: delta,
          animationProgress: animationProgress,
          size: size);
    } else {
      return __generateArrowDown(
          position: position,
          delta: delta,
          animationProgress: animationProgress,
          size: size);
    }
  }

  ArrowCubit __generateArrowUp(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0,
      Offset? size}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.arrowW, gs.arrowH),
        opacity: 1.0,
        direction: Direction.up,
        radius: gs.radius,
        animProgress: animationProgress,
      ),
    );
  }

  ArrowCubit __generateArrowDown(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0,
      Offset? size}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.wUnit, gs.hUnit),
        opacity: 1.0,
        direction: Direction.down,
        radius: gs.radius,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      double widthRatio = 1.25,
      Offset? size,
      required Direction direction}) {
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.wUnit * widthRatio, gs.floorH),
        opacity: 1.0,
        radius: gs.radius,
      ),
    );
  }
}
