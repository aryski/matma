import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';

extension Initializer on StepsSimulationBloc {
  List<StepsSimulationNumberState> initializeSimulationItems() {
    //print("init");
    List<int> init = board.state.numbers;
    var currentTop =
        (simSize.hUnits / 2).floor() * simSize.hRatio - simSize.hRatio;
    var currentLeft = simSize.wRatio * 2;
    var id = UniqueKey();
    state.unorderedItems[id] = EquatorCubit(EquatorState(
        defColor: defaultEquator,
        hovColor: defaultEquator,
        id: id,
        position: Offset(0, currentTop + simSize.hRatio),
        size: Offset(simSize.wRatio * (simSize.wUnits), simSize.hRatio / 5),
        color: defaultEquator,
        opacity: 1,
        radius: 1 / 15 * simSize.wRatio));
    return generateFloorsAndArrows(init, currentLeft, currentTop);
  }

  List<StepsSimulationNumberState> generateFloorsAndArrows(
      List<int> init, double currentLeft, double currentTop) {
    List<StepsSimulationNumberState> result = [];
    for (int number in init) {
      final List<StepsSimulationDefaultItem> items = [];
      if (number != 0) {
        for (int i = 0; i < number.abs(); i++) {
          //Step insertion
          var pos = Offset(currentLeft, currentTop);
          ArrowCubit arrow;
          FloorCubit floor;
          if (number > 0) {
            arrow = generateArrowUp(position: pos, delta: Offset.zero);
            floor = generateFloor(
                position: pos, delta: Offset(simSize.wRatio / 2, 0));
          } else {
            arrow = generateArrowDown(
                position: pos,
                delta: Offset(0, simSize.hRatio + simSize.hRatio / 5));
            floor = generateFloor(
                position: pos,
                delta: Offset(simSize.wRatio / 2, 2 * simSize.hRatio));
          }
          if (i + 1 == number.abs() && init.last == number) {
            floor.updateColor(defaultYellow, darkenColor(defaultYellow, 20));
          }
          items.add(StepsSimulationDefaultItem(arrow: arrow, floor: floor));
          //Position update
          if (number > 0) {
            currentTop -= simSize.hRatio;
          } else {
            currentTop += simSize.hRatio;
          }
          currentLeft += simSize.wRatio;
        }
      }
      //print("LEN");
      //print(items.length);
      result.add(StepsSimulationNumberState(items));
    }
    return result;
  }
}
