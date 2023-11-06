import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

extension ItemsGenerator on StepsGameBloc {
  ArrowCubit generateArrow(
      {required Offset position,
      double animationProgress = 1.0,
      Offset? size,
      required Direction direction}) {
    return ArrowCubit(
      ArrowState(
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(gs.arrowW, gs.arrowH),
        opacity: 1.0,
        direction: direction,
        radius: gs.radius,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      double? widthSize,
      Offset? size,
      required Direction direction}) {
    widthSize ??= gs.floorW;
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(widthSize, gs.floorH),
        opacity: 1.0,
        radius: gs.radius,
      ),
    );
  }
}
