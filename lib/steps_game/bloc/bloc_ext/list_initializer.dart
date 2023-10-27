import 'package:flutter/material.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/equator/cubit/equator_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension Initializer on StepsGameBloc {
  List<StepsGameNumberState> initializeSimulationItems() {
    var initialTop = (gs.hUnits / 2).floor() * gs.hUnit - gs.hUnit;
    var initialLeft = gs.wUnit * 2;
    _generateEquator(initialTop);
    return _generateSteps(board.state.numbers, initialLeft, initialTop);
  }

  void _generateEquator(double currentTop) {
    var id = UniqueKey();
    state.unorderedItems[id] = EquatorCubit(EquatorState(
        id: id,
        position: Offset(0, currentTop + gs.hUnit),
        size: Offset(gs.wUnit * (gs.wUnits), gs.floorH),
        opacity: 1,
        radius: gs.radius));
  }

  List<StepsGameNumberState> _generateSteps(
      List<int> init, double currentLeft, double currentTop) {
    init.removeWhere((element) => element == 0);
    List<StepsGameNumberState> result = [];
    for (int j = 0; j < init.length; j++) {
      int number = init[j];
      int stepsCount = number.abs();
      final List<StepsGameDefaultItem> steps = [];
      bool nextNumberSameSign = isNextNumberSameSign(j, init, number);
      for (int i = 0; i < stepsCount; i++) {
        var pos = Offset(currentLeft, currentTop);
        double floorWidth = gs.floorW;
        if (nextNumberSameSign && i + 1 == stepsCount) {
          floorWidth = gs.floorWExt;
        }
        var isPositive = number > 0;
        var step = generateStep(pos, isPositive, floorWidth);
        _updateLastness(
            isLastInNumber: i + 1 == stepsCount,
            isLastInGame: j + 1 == init.length,
            floor: step.floor);
        steps.add(step);

        currentTop += isPositive ? -gs.hUnit : gs.hUnit;
        currentLeft += (floorWidth == gs.floorWExt) ? gs.wUnit * 2 : gs.wUnit;
      }
      result.add(StepsGameNumberState(steps));
    }
    return result;
  }

  StepsGameDefaultItem generateStep(Offset pos, bool isPos, double floorWidth) {
    ArrowCubit arrow = generateArrow(
        position: pos,
        delta: Offset(0, isPos ? 0 : (gs.hUnit + gs.floorH)),
        direction: isPos ? Direction.up : Direction.down);
    FloorCubit floor = generateFloor(
      direction: isPos ? Direction.up : Direction.down,
      widthSize: floorWidth,
      position: pos += Offset(gs.wUnit / 2, isPos ? 0 : 2 * gs.hUnit),
    );
    return StepsGameDefaultItem(arrow: arrow, floor: floor);
  }
}

void _updateLastness(
    {required bool isLastInNumber,
    required bool isLastInGame,
    required FloorCubit floor}) {
  if (isLastInNumber) {
    if (isLastInGame) {
      floor.setLastInGame();
    }
    floor.setLastInNumber();
  }
}

bool isNextNumberSameSign(int j, List<int> init, int number) {
  if (j + 1 < init.length) {
    int nextNumber = init[j + 1];
    if (nextNumber * number > 0) {
      return true;
    }
  }
  return false;
}
