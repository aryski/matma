import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension NumberSplitJoiner on StepsGameBloc {
  void handleJoin2(FloorCubit item, double delta, GameSize gs,
      StepsGameState state, Emitter<StepsGameState> emit) {
    delta = _guardDeltaSize(
        currentW: item.state.size.value.dx, delta: delta, minW: gs.floorW);
    if (delta != 0) taskCubit.scrolled();
    item.updateSize(Offset(delta, 0), 200);
    int? numberInd = state.getNumberIndexFromItem(item);
    if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
      if (item.state.size.value.dx <= gs.floorW) {
        print("JOIN");
        handleJoin(state, numberInd, item, delta);
      }
      state.updatePositionSince(
          item: item,
          offset: Offset(delta, 0),
          fillingIncluded: false,
          milliseconds: 200);
      generateFillings();
      // item.updateSize(Offset(delta, 0));
      updateFillingWidth(state, item, delta);
      // state.updatePositionSince(item, Offset(delta, 0));
      emit(state.copy());
    }
  }

  void handleSplit2(FloorCubit item, double delta, GameSize gs,
      StepsGameState state, Emitter<StepsGameState> emit, int milliseconds) {
    delta = _guardDeltaSize(
        currentW: item.state.size.value.dx, delta: delta, minW: gs.floorW);
    if (delta != 0) taskCubit.scrolled();
    item.updateSize(Offset(delta, 0), 200);
    var newW = item.state.size.value.dx;
    int? numberInd = state.getNumberIndexFromItem(item);
    if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
      if (newW > gs.floorW) {
        print("SPLIT");
        handleSplit(state, item, numberInd, delta);
      }
      state.updatePositionSince(
          item: item, offset: Offset(delta, 0), milliseconds: milliseconds);
      generateFillings();
      emit(state.copy());
    }
  }

  void handleSplit(
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
          ?.updatePositionDelayed(Offset(delta, 0), const Duration(milliseconds: 20));
    }
  }

  void handleJoin(
      StepsGameState state, int numberInd, FloorCubit item, double delta) {
    if (state.numbers[numberInd].steps.last.floor == item) {
      int nextInd = numberInd + 1;
      if (nextInd < state.numbers.length) {
        var number = state.numbers[numberInd];
        var nextNumber = state.numbers[nextInd];
        if (number.number * nextNumber.number > 0) {
          board.add(
              EquationEventJoinNumbers(leftInd: numberInd, rightInd: nextInd));
          item.setNotLastInNumber();
          number.steps.addAll(nextNumber.steps);
          nextNumber.filling?.updatePosition(Offset(delta, 0));
          removeFilling(state, nextInd);
          state.numbers.remove(nextNumber);
        }
      }
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

double _guardDeltaSize(
    {required double currentW, required double delta, required double minW}) {
  if (currentW + delta < minW) {
    delta = (minW - currentW) *
        1.0000000000001; //TODO better floating point solution.
  }
  return delta;
}
