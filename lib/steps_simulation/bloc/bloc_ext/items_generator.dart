import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension ItemsGenerator on StepsSimulationBloc {
  ArrowCubit generateArrowUp(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0,
      Offset? size}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        color: defaultGreen,
        defColor: defaultGreen,
        hovColor: darkenColor(defaultGreen, 20),
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wUnit, simSize.hUnit),
        opacity: 1.0,
        direction: Direction.up,
        radius: simSize.wUnit / 15,
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
        color: defaultRed,
        defColor: defaultRed,
        hovColor: darkenColor(defaultRed, 20),
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wUnit, simSize.hUnit),
        opacity: 1.0,
        direction: Direction.down,
        radius: simSize.wUnit / 15,
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
        color: defaultGrey,
        defColor: defaultGrey,
        hovColor: darkenColor(defaultGrey, 20),
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wUnit * widthRatio, simSize.hUnit / 5),
        opacity: 1.0,
        radius: simSize.wUnit / 15,
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
        color: defaultYellow,
        defColor: defaultYellow,
        hovColor: darkenColor(defaultYellow, 20),
        id: UniqueKey(),
        position: position,
        size: size ?? Offset(simSize.wUnit * widthRatio, simSize.hUnit / 5),
        opacity: 1.0,
        radius: simSize.wUnit / 15,
      ),
    );
  }
}
