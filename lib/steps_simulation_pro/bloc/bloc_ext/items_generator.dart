import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension ItemsGenerator on StepsSimulationProBloc {
  SimulationItemCubit generateArrowUp(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        color: const Color.fromARGB(255, 68, 157, 114),
        defColor: const Color.fromARGB(255, 68, 157, 114),
        hovColor: const Color.fromARGB(255, 54, 126, 92),
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit, simSize.hUnit),
        opacity: 1.0,
        direction: Direction.up,
        radius: simSize.wUnit / 15,
        animProgress: animationProgress,
      ),
    );
  }

  SimulationItemCubit generateArrowDown(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        color: Colors.redAccent,
        defColor: Colors.redAccent,
        hovColor: const Color.fromARGB(255, 185, 60, 60),
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit, simSize.hUnit),
        opacity: 1.0,
        direction: Direction.down,
        radius: simSize.wUnit / 15,
        animProgress: animationProgress,
      ),
    );
  }

  SimulationItemCubit generateFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25}) {
    position += delta;
    return FloorCubit(
      FloorState(
        color: Colors.grey,
        defColor: Colors.grey,
        hovColor: const Color.fromARGB(255, 112, 112, 112),
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit * widthRatio, simSize.hUnit / 7),
        opacity: 1.0,
        radius: simSize.wUnit / 15,
      ),
    );
  }
}
