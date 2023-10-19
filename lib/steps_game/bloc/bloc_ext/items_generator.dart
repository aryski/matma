import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
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
        size: size ?? Offset(simSize.wRatio, simSize.hRatio),
        opacity: 1.0,
        direction: Direction.up,
        radius: 1 / 15 * simSize.wRatio,
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
        size: size ?? Offset(simSize.wRatio, simSize.hRatio),
        opacity: 1.0,
        direction: Direction.down,
        radius: 1 / 15 * simSize.wRatio,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25,
      Offset? size}) {
    position += delta;
    return FloorCubit(
      FloorState(
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wRatio * widthRatio, simSize.hRatio / 5),
        opacity: 1.0,
        radius: 1 / 15 * simSize.wRatio,
      ),
    );
  }

  FloorCubit generateYellowFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25,
      Offset? size}) {
    position += delta;
    return FloorCubit(
      FloorState(
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wRatio * widthRatio, simSize.hRatio / 5),
        opacity: 1.0,
        radius: 1 / 15 * simSize.wRatio,
      ),
    );
  }
}
