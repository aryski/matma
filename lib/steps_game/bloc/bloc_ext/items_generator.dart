import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';

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
        size: size ?? AnimatedProp.zero(value: Offset(gs.arrowW, gs.arrowH)),
        opacity: AnimatedProp.zero(value: 1.0),
        direction: direction,
        radius: gs.radius,
        animProgress: animationProgress,
      ),
    );
  }

  FloorCubit generateFloor(
      {required Offset position,
      double? widthSize,
      AnimatedProp<Offset>? size,
      required Direction direction}) {
    widthSize ??= gs.floorW;
    return FloorCubit(
      FloorState(
        direction: direction,
        id: UniqueKey(),
        position: AnimatedProp.zero(value: position),
        size: size ?? AnimatedProp.zero(value: Offset(widthSize, gs.floorH)),
        opacity: AnimatedProp.zero(value: 1.0),
        radius: gs.radius,
      ),
    );
  }
}
