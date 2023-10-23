import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
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
        id: id,
        position: Offset(0, currentTop + simSize.hRatio),
        size: Offset(simSize.wRatio * (simSize.wUnits), simSize.hRatio / 5),
        opacity: 1,
        radius: 1 / 15 * simSize.wRatio));
    return generateFloorsAndArrows(init, currentLeft, currentTop);
  }

  List<StepsGameNumberState> generateFloorsAndArrows(
      List<int> init, double currentLeft, double currentTop) {
    init.removeWhere((element) => element == 0);
    List<StepsGameNumberState> result = [];
    for (int j = 0; j < init.length; j++) {
      int number = init[j];

      final List<StepsGameDefaultItem> items = [];
      bool nextNumberSameSign = false;
      if (j + 1 < init.length) {
        int nextNumber = init[j + 1];
        if (nextNumber * number > 0) {
          nextNumberSameSign = true;
        }
      }
      for (int i = 0; i < number.abs(); i++) {
        //Step insertion
        var pos = Offset(currentLeft, currentTop);
        ArrowCubit arrow;
        FloorCubit floor;
        double floorLengthRatio = 1.25;
        if (nextNumberSameSign && i + 1 == number.abs()) {
          floorLengthRatio = 2.25;
        }
        if (number > 0) {
          arrow = generateArrowUp(position: pos, delta: Offset.zero);
          floor = generateFloor(
              direction: Direction.up,
              widthRatio: floorLengthRatio,
              position: pos,
              delta: Offset(simSize.wRatio / 2, 0));
        } else {
          arrow = generateArrowDown(
              position: pos,
              delta: Offset(0, simSize.hRatio + simSize.hRatio / 5));
          floor = generateFloor(
              direction: Direction.down,
              widthRatio: floorLengthRatio,
              position: pos,
              delta: Offset(
                simSize.wRatio / 2,
                2 * simSize.hRatio,
              ));
        }
        if (i + 1 == number.abs()) {
          if (j + 1 == init.length) {
            floor.setLastLast();
          }
          floor.setLast();
        }
        items.add(StepsGameDefaultItem(arrow: arrow, floor: floor));
        if (number > 0) {
          currentTop -= simSize.hRatio;
        } else {
          currentTop += simSize.hRatio;
        }
        currentLeft +=
            (floorLengthRatio == 2.25) ? simSize.wRatio * 2 : simSize.wRatio;
      }

      result.add(StepsGameNumberState(items));
    }
    return result;
  }
}
