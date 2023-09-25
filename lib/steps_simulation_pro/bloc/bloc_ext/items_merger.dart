import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

extension ItemsMerger on StepsSimulationProBloc {
  bool isMergeCandidate(
      SimulationItemCubit? item, StepsSimulationProState state) {
    if (item != null) {
      var left = state.leftItem(item);
      var right = state.rightItem(item);
      if (left is ArrowCubit && right is ArrowCubit) {
        if (left.state.direction != right.state.direction) {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> tryMerge(FloorCubit item) async {
    //TODO merging board update
    var left = state.leftItem(item);
    var right = state.rightItem(item);
    if (left is ArrowCubit && right is ArrowCubit) {
      if (left.state.direction != right.state.direction) {
        //merge
        left.updatePosition(Offset(0, simSize.hUnit));
        right.updatePosition(Offset(0, simSize.hUnit));
        item.updatePosition(Offset(0, simSize.hUnit));
        left.setOpacity(0);
        right.setOpacity(0);
        item.setOpacity(0);
        var inheritedWidth = 0.0;
        var rightAfterRight = state.rightItem(right);
        if (rightAfterRight is FloorCubit) {
          inheritedWidth = rightAfterRight.state.size.dx - simSize.wUnit / 2;
        }
        var leftAfterLeft = state.leftItem(left);
        if (leftAfterLeft is FloorCubit) {
          leftAfterLeft.updateSize(Offset(inheritedWidth, 0));
        }
        await Future.delayed(const Duration(milliseconds: 200));
        if (rightAfterRight is FloorCubit) {
          state.removeItem(rightAfterRight);
        }
        //righ i left parents
        state.reduceItemNumber(left);
        state.reduceItemNumber(right);

        var indLeft = state.getNumberIndex(left);
        var indRight = state.getNumberIndex(right);
        if (indLeft != null && indRight != null) {
          board.add(EquationBoardEventMergeNumbers(
              indLeft: indLeft, indRight: indRight));
        }

        state.removeItem(right);
        state.removeItem(item);
        state.removeItem(left);
      }
    }
    return true;
    // emit(state.copy());
  }
}
