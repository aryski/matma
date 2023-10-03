import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension ArrowsReductor on StepsSimulationBloc {
  Future<bool> handleReduction(
      SimulationItemCubit? item,
      double delta,
      double defaultWidth,
      StepsSimulationState state,
      Emitter<StepsSimulationState> emit) async {
    if (!areNeighborsOpposite(item, state) ||
        item is! FloorCubit ||
        item.state.opacity <= 0) {
      return false;
    }
    var currentWidth = item.state.size.dx;
    if (currentWidth + delta < defaultWidth) {
      delta = -currentWidth; //zerujemy dlugosc
    }
    item.updateSize(Offset(delta, 0));
    state.moveAllSince(item, Offset(delta, 0));
    if (currentWidth + delta < defaultWidth) {
      var step = state.getStep(item);
      if (step == null) return false;
      var rightStep = state.rightStep(step);
      if (rightStep == null) return false;
      await performReduction(item, step, rightStep);
      taskCubit.merged();
    }
    emit(state.copy());
    return true;
  }

  bool areNeighborsOpposite(
      SimulationItemCubit? item, StepsSimulationState state) {
    if (item is FloorCubit) {
      var step = state.getStep(item);
      if (step == null) return false;
      var rightStep = state.rightStep(step);
      if (rightStep == null) return false;
      var left = step.arrow;
      var right = rightStep.arrow;
      if (left.state.direction != right.state.direction) {
        return true;
      }
    }
    return false;
  }

  Future<void> performReduction(
      FloorCubit floor,
      StepsSimulationDefaultItem step,
      StepsSimulationDefaultItem rightStep) async {
    var mid = step.arrow;
    var right = rightStep.arrow;

    mid.updatePosition(Offset(0, simSize.hUnit));
    right.updatePosition(Offset(0, simSize.hUnit));
    floor.updatePosition(Offset(0, simSize.hUnit));
    mid.setOpacity(0);
    right.setOpacity(0);
    floor.setOpacity(0);

    var inheritedWidth = 0.0;
    inheritedWidth = rightStep.floor.state.size.dx - simSize.wUnit / 2;
    var leftStep = state.leftStep(step);
    if (leftStep != null) {
      leftStep.floor.updateSize(Offset(inheritedWidth, 0));
    }
    if (state.isFirstStep(step)) {
      state.moveAllSince(
          rightStep.floor, Offset(-rightStep.floor.state.size.dx, 0));
      rightStep.floor.updateSize(Offset(-rightStep.floor.state.size.dx, 0));
    }

    await Future.delayed(const Duration(milliseconds: 200));
    var indLeft = state.getNumberIndex(step);
    var indRight = state.getNumberIndex(rightStep);
    if (indLeft != null && indRight != null) {
      board.add(EquationBoardEventNumbersReduction(
          indLeft: indLeft, indRight: indRight));
    }

    state.removeStep(step);
    state.removeStep(rightStep);
    if (leftStep != null && state.isLastItem(leftStep.floor)) {
      leftStep.floor.updateSize(
          Offset(-leftStep.floor.state.size.dx + 1.25 * simSize.wUnit, 0));
      leftStep.floor.updateColor(defaultYellow, darkenColor(defaultYellow, 20));
    }
  }
}
