import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/steps_game/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension NumberSplitter on StepsGameBloc {
  void handleSplit(FloorCubit item, double delta, GameSize gs,
      StepsGameState state, Emitter<StepsGameState> emit, int milliseconds) {
    delta = guardDeltaSize(
        currentW: item.state.size.value.dx, delta: delta, minW: gs.floorW);
    if (delta != 0) taskCubit.scrolled();
    item.updateSize(Offset(delta, 0), milliseconds: 200);
    var newW = item.state.size.value.dx;
    int? numberInd = state.getNumberIndexFromItem(item);
    if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
      if (newW > gs.floorW) {
        handleSplitCore(state, item, numberInd, delta);
      }
      state.updatePositionSince(
          item: item, offset: Offset(delta, 0), milliseconds: milliseconds);
      generateFillings();
      emit(state.copy());
    }
  }

  void handleSplitCore(
      StepsGameState state, FloorCubit item, int numberInd, double delta) {
    var myStep = state.getStep(item);
    if (myStep != null && state.numbers[numberInd].steps.last != myStep) {
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
          animateNeigboringFillings(ind, false);
        }
      } else if (item.state.direction == Direction.up) {
        var ind = state.getNumberIndexFromItem(item);
        if (ind != null) {
          animateNeigboringFillings(ind, false);
        }
      }
    }
    if (delta != 0) {
      taskCubit.scrolled();
    }
    var id = state.getNumberIndexFromItem(item);
    if (id != null && state.numbers[id].steps.last.floor != item) {
      state.numbers[id].filling
          ?.updatePosition(Offset(delta, 0), delayInMillis: 20);
    }
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

// double _guardDeltaSize(
//     {required double currentW, required double delta, required double minW}) {
//   if (currentW + delta < minW) {
//     delta = (minW - currentW) *
//         1.0000000000001; //TODO better floating point solution.
//   }
//   return delta;
// }
