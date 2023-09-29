import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';

extension Initializer on StepsSimulationBloc {
  List<StepsSimulationNumberState> initializeItemsList() {
    List<int> init = board.state.numbers;
    var currentTop =
        (simSize.hUnits / 2).floor() * simSize.hUnit - simSize.hUnit;
    var currentLeft = simSize.wUnit * 2;
    var id = UniqueKey();
    state.unorderedItems[id] = EquatorCubit(EquatorState(
        defColor: const Color.fromARGB(255, 33, 45, 67),
        hovColor: const Color.fromARGB(255, 33, 45, 67),
        id: id,
        position: Offset(0, currentTop + simSize.hUnit),
        size: Offset(simSize.wUnit * (simSize.wUnits), simSize.hUnit / 5),
        color: const Color.fromARGB(255, 33, 45, 67),
        opacity: 1,
        radius: simSize.wUnit / 15));
    List<StepsSimulationNumberState> result = [];
    for (int number in init) {
      final List<StepsSimulationDefaultItem> items = [];
      if (number > 0) {
        for (int i = 0; i < number; i++) {
          var pos = Offset(currentLeft, currentTop);
          items.add(StepsSimulationDefaultItem(
              arrow: generateArrowUp(position: pos, delta: Offset.zero),
              floor: generateFloor(
                  position: pos, delta: Offset(simSize.wUnit / 2, 0))));
          currentTop -= simSize.hUnit;
          currentLeft += simSize.wUnit;
        }
      } else {
        for (int i = 0; i > number; i--) {
          var pos = Offset(currentLeft, currentTop);
          ArrowCubit arrow = generateArrowDown(
              position: pos,
              delta: Offset(0, simSize.hUnit + simSize.hUnit / 5));
          FloorCubit floor = generateFloor(
              position: pos,
              delta: Offset(simSize.wUnit / 2, 2 * simSize.hUnit));
          if (i - 1 == number && init.last == number) {
            floor.updateColor(defaultYellow, darkenColor(defaultYellow, 20));
          }
          items.add(StepsSimulationDefaultItem(arrow: arrow, floor: floor));

          currentTop += simSize.hUnit;
          currentLeft += simSize.wUnit;
        }
      }
      result.add(StepsSimulationNumberState(items));
    }
    return result;
  }
}
