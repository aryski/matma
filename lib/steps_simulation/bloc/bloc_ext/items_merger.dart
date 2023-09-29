import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension ItemsMerger on StepsSimulationBloc {
  bool isMergeCandidate(SimulationItemCubit? item, StepsSimulationState state) {
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

  Future<bool> tryMerge(FloorCubit item) async {
    var step = state.getStep(item);
    if (step == null) return false;
    var rightStep = state.rightStep(step);
    if (rightStep == null) return false;

    var left = step.arrow;
    var right = rightStep.arrow;

    if (left.state.direction != right.state.direction) {
      left.updatePosition(Offset(0, simSize.hUnit));
      right.updatePosition(Offset(0, simSize.hUnit));
      item.updatePosition(Offset(0, simSize.hUnit));
      left.setOpacity(0);
      right.setOpacity(0);
      item.setOpacity(0);

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
        board.add(EquationBoardEventMergeNumbers(
            indLeft: indLeft, indRight: indRight));
      }

      state.removeStep(step);
      state.removeStep(rightStep);
      if (leftStep != null && state.isLastItem(leftStep.floor)) {
        leftStep.floor.updateSize(
            Offset(-leftStep.floor.state.size.dx + 1.25 * simSize.wUnit, 0));
        leftStep.floor
            .updateColor(defaultYellow, darkenColor(defaultYellow, 20));
      }
      //it removes steps but it doesnt remove numbers numbers can be removed only by reducer
    }

    return true;
  }
}
