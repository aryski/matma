import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';

extension NumberSplitJoiner on StepsSimulationBloc {
  bool handleSplitJoin(
      SimulationItemCubit? item,
      double delta,
      double minWidth,
      SimulationSize simSize,
      StepsSimulationState state,
      Emitter<StepsSimulationState> emit) {
    if (item is! FloorCubit || item.state.opacity <= 0) return false;
    // adjusting delta, so the width is at least endW
    var currentWidth = item.state.size.dx;
    if (currentWidth + delta < minWidth) {
      delta = minWidth - currentWidth;
    }

    item.updateSize(Offset(delta, 0));
    if (item.state.size.dx > 1.25 * simSize.wUnit) {
      var myStep = state.getStep(item);
      if (myStep != null) {
        int? numberInd = state.getNumberIndex(myStep);
        if (numberInd != null) {
          var number = state.numbers[numberInd];
          //todo split number at
          if (number.steps.last != myStep) {
            List<StepsSimulationDefaultItem> left = [];
            List<StepsSimulationDefaultItem> right = [];
            List<StepsSimulationDefaultItem> current = left;
            bool changed = false;
            for (var step in number.steps) {
              current.add(step);
              if (!changed && step == myStep) {
                current = right;
                changed = true;
              }
            }
            state.numbers[numberInd].steps.clear();
            state.numbers[numberInd].steps.addAll(left);
            state.numbers
                .insert(numberInd + 1, StepsSimulationNumberState(right));
            board.add(EquationBoardEventSplitNumber(
                ind: numberInd,
                leftValue: state.numbers[numberInd].number,
                rightValue: state.numbers[numberInd + 1].number));
            taskCubit.splited();
          }
        }
      }
    }

    if (item.state.size.dx <= 1.25 * simSize.wUnit) {
      var step = state.getStep(item);
      if (step != null) {
        int? numberInd = state.getNumberIndex(step);

        if (numberInd != null) {
          int? nextInd = numberInd + 1;
          if (nextInd < state.numbers.length) {
            var number = state.numbers[numberInd];
            var nextNumber = state.numbers[nextInd];
            if (number.number * nextNumber.number > 0) {
              //same sign trzeba zmergowac TODO bledy czasem
              board.add(EquationBoardEventJoinNumbers(
                  leftInd: numberInd, rightInd: nextInd));
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
    state.moveAllSince(item, Offset(delta, 0));
    emit(state.copy());
    return true;
  }
}
