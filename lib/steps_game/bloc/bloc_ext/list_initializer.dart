import 'package:flutter/material.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension Initializer on StepsGameBloc {
  List<StepsGameNumberState> initializeSimulationItems() {
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

  List<StepsGameNumberState> generateFloorsAndArrows(
      List<int> init, double currentLeft, double currentTop) {
    List<StepsGameNumberState> result = [];
    for (int number in init) {
      final List<StepsGameDefaultItem> items = [];
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
          items.add(StepsGameDefaultItem(arrow: arrow, floor: floor));
          if (number > 0) {
            currentTop -= simSize.hRatio;
          } else {
            currentTop += simSize.hRatio;
          }
          currentLeft += simSize.wRatio;
        }
      }
      result.add(StepsGameNumberState(items));
    }
    return result;
  }
}
