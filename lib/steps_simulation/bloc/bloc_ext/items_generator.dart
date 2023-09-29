import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

final Color defaultGreen = Color.alphaBlend(
    const Color.fromARGB(255, 32, 200, 107).withOpacity(0.9),
    const Color.fromARGB(255, 23, 33, 50));
final Color defaultGrey = Color.alphaBlend(
    const Color.fromARGB(255, 217, 217, 217).withOpacity(0.5),
    const Color.fromARGB(255, 23, 33, 50));
final Color defaultRed = Color.alphaBlend(
    const Color.fromARGB(255, 249, 56, 101).withOpacity(0.9),
    const Color.fromARGB(255, 23, 33, 50));

int reduceNegative(int value) {
  return value < 0 ? 0 : value;
}

Color darkenColor(Color color, int delta) {
  int red = reduceNegative(color.red - delta);
  int blue = reduceNegative(color.blue - delta);
  int green = reduceNegative(color.green - delta);
  return Color.fromARGB(255, red, green, blue);
}

extension ItemsGenerator on StepsSimulationBloc {
  ArrowCubit generateArrowUp(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        color: defaultGreen,
        defColor: defaultGreen,
        hovColor: darkenColor(defaultGreen, 20),
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

  ArrowCubit generateArrowDown(
      {required Offset position,
      Offset delta = Offset.zero,
      double animationProgress = 1.0}) {
    position += delta;
    return ArrowCubit(
      ArrowState(
        color: defaultRed,
        defColor: defaultRed,
        hovColor: darkenColor(defaultRed, 20),
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

  FloorCubit generateFloor(
      {required Offset position,
      Offset delta = Offset.zero,
      double widthRatio = 1.25}) {
    position += delta;
    return FloorCubit(
      FloorState(
        color: defaultGrey,
        defColor: defaultGrey,
        hovColor: darkenColor(defaultGrey, 20),
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit * widthRatio, simSize.hUnit / 5),
        opacity: 1.0,
        radius: simSize.wUnit / 15,
      ),
    );
  }
}
