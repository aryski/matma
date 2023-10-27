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
    var currentTop = (gs.hUnits / 2).floor() * gs.hUnit - gs.hUnit;
    var currentLeft = gs.wUnit * 2;
    var id = UniqueKey();
    state.unorderedItems[id] = EquatorCubit(EquatorState(
        id: id,
        position: Offset(0, currentTop + gs.hUnit),
        size: Offset(gs.wUnit * (gs.wUnits), gs.floorH),
        opacity: 1,
        radius: gs.radius));
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
          arrow = generateArrow(
              position: pos, delta: Offset.zero, direction: Direction.up);
          floor = generateFloor(
            direction: Direction.up,
            widthRatio: floorLengthRatio,
            position: pos,
          );
          floor.updatePosition(Offset(gs.wUnit / 2, 0));
        } else {
          arrow = generateArrow(
              position: pos,
              delta: Offset(0, gs.hUnit + gs.floorH),
              direction: Direction.down);
          floor = generateFloor(
            direction: Direction.down,
            widthRatio: floorLengthRatio,
            position: pos,
          );
          floor.updatePosition(
            Offset(
              gs.wUnit / 2,
              2 * gs.hUnit,
            ),
          );
        }
        if (i + 1 == number.abs()) {
          if (j + 1 == init.length) {
            floor.setLastLast();
          }
          floor.setLast();
        }
        items.add(StepsGameDefaultItem(arrow: arrow, floor: floor));
        if (number > 0) {
          currentTop -= gs.hUnit;
        } else {
          currentTop += gs.hUnit;
        }
        currentLeft += (floorLengthRatio == 2.25) ? gs.wUnit * 2 : gs.wUnit;
      }

      result.add(StepsGameNumberState(items));
    }
    return result;
  }
}
