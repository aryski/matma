import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension NumberSplitJoiner on StepsGameBloc {
  bool handleSplitJoin(FloorCubit item, double delta, GameSize gs,
      StepsGameState state, Emitter<StepsGameState> emit) {
    delta = _guardDeltaSize(
        currentW: item.state.size.dx, delta: delta, minW: gs.floorW);
    item.updateSize(Offset(delta, 0));
    var newW = item.state.size.dx;
    if (newW > gs.floorW) {
      var myStep = state.getStep(item);
      int? numberInd = state.getNumberIndexFromItem(item);
      if (myStep != null &&
          numberInd != null &&
          state.numbers[numberInd].steps.last != myStep) {
        _splitNumber(
            numberInd: numberInd, splitStep: myStep, numbers: state.numbers);
        board.add(EquationEventSplitNumber(
            ind: numberInd,
            leftValue: state.numbers[numberInd].number,
            rightValue: state.numbers[numberInd + 1].number));
        item.setLastInNumber();
        taskCubit.splited();
        if (item.state.direction == Direction.down) {
          var ind = state.getNumberIndexFromItem(item);
          if (ind != null) {
            eloElo2(ind, false);
          }
        } else if (item.state.direction == Direction.up) {
          var ind = state.getNumberIndexFromItem(item);
          if (ind != null) {
            eloElo2(ind, false);
          }
        }
      }
    }

    if (item.state.size.dx <= gs.floorW) {
      int? numberInd = state.getNumberIndexFromItem(item);
      if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
        //only neighbors
        if (state.numbers[numberInd].steps.last.floor == item) {
          int? nextInd = numberInd + 1;
          if (nextInd < state.numbers.length) {
            var number = state.numbers[numberInd];
            var nextNumber = state.numbers[nextInd];
            if (number.number * nextNumber.number > 0) {
              board.add(EquationEventJoinNumbers(
                  leftInd: numberInd, rightInd: nextInd));
              item.setNotLastInNumber();
              number.steps.addAll(nextNumber.steps);
              state.numbers.remove(nextNumber);
            }
          }
        }
      }
    }
    if (delta != 0) {
      taskCubit.scrolled();
    }
    state.updatePositionSince(item, Offset(delta, 0));
    generateFillings();
    // beforeEmit();
    emit(state.copy());
    var id = state.getNumberIndexFromItem(item);
    if (id != null && state.numbers[id].steps.last.floor != item) {
      state.numbers[id].filling
          ?.updatePositionDelayed(Offset(delta, 0), Duration(milliseconds: 20));
    }

    return true;
  }
}

void _splitNumber(
    {required int numberInd,
    required StepsGameDefaultItem splitStep,
    required List<StepsGameNumberState> numbers}) {
  List<StepsGameDefaultItem> left = [];
  List<StepsGameDefaultItem> right = [];
  List<StepsGameDefaultItem> current = left;
  bool changed = false;
  var number = numbers[numberInd];
  for (var step in number.steps) {
    current.add(step);
    if (!changed && step == splitStep) {
      current = right;
      changed = true;
    }
  }
  numbers[numberInd].steps.clear();
  numbers[numberInd].steps.addAll(left);
  numbers.insert(numberInd + 1, StepsGameNumberState(steps: right));
}

double _guardDeltaSize(
    {required double currentW, required double delta, required double minW}) {
  if (currentW + delta < minW) {
    delta = minW - currentW;
  }
  return delta;
}
