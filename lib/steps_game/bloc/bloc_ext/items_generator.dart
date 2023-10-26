import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

extension ItemsGenerator on StepsGameBloc {
  ArrowCubit generateArrowUp(
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
        direction: Direction.up,
        radius: 1 / 15 * gs.wUnit,
        animProgress: animationProgress,
      ),
    );
  }

  ArrowCubit generateArrowDown(
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
        radius: 1 / 15 * gs.wUnit,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25,
      Offset? size,
      required Direction direction}) {
    position += delta;
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.wUnit * widthRatio, gs.hUnit / 5),
        opacity: 1.0,
        radius: 1 / 15 * gs.wUnit,
      ),
    );
  }

  FloorCubit generateYellowFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25,
      Offset? size,
      required Direction direction}) {
    position += delta;
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.wUnit * widthRatio, gs.hUnit / 5),
        opacity: 1.0,
        radius: 1 / 15 * gs.wUnit,
      ),
    );
  }
}
