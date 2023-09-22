import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

extension ItemsMerger on StepsSimulationProBloc {
  bool isMergeCandidate(
      SimulationItemCubit item, StepsSimulationProState state) {
    var items = state.items;
    if (item is FloorCubit) {
      var i = state.getIndex(item.state.id);
      if (0 <= i - 1 && items[i - 1] is ArrowCubit) {
        if (i + 1 < items.length && items[i + 1] is ArrowCubit) {
          var leftDir = (items[i - 1] as ArrowCubit).state.direction;
          var rightDir = (items[i + 1] as ArrowCubit).state.direction;
          if (leftDir != rightDir) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void tryMerge(FloorCubit item, StepsSimulationProState state) {
    var i = state.getIndex(item.state.id);
    if (0 <= i - 1 && state.items[i - 1] is ArrowCubit) {
      if (i + 1 < state.items.length && state.items[i + 1] is ArrowCubit) {
        var leftDir = (state.items[i - 1] as ArrowCubit).state.direction;
        var rightDir = (state.items[i + 1] as ArrowCubit).state.direction;
        if (leftDir != rightDir) {
          //merge
          state.items[i - 1].updatePosition(Offset(0, simSize.hUnit));
          state.items[i + 1].updatePosition(Offset(0, simSize.hUnit));
          state.items[i].updatePosition(Offset(0, simSize.hUnit));
          state.items[i - 1].setOpacity(0);
          state.items[i + 1].setOpacity(0);
          state.items[i].setOpacity(0);
          var inheritedWidth = 0.0;
          if (i + 2 < state.items.length && state.items[i + 2] is FloorCubit) {
            inheritedWidth =
                state.items[i + 2].state.size.dx - simSize.wUnit / 2;
          }
          if (i - 2 >= 0 && state.items[i - 2] is FloorCubit) {
            (state.items[i - 2] as FloorCubit)
                .updateSize(Offset(inheritedWidth, 0));
          }
          //DO WYWALENIA
          //i-1, i, i+1, i+2
        }
      }
    }
  }

  void tryFinishMerge(FloorCubit item, StepsSimulationProState state) {
    var i = state.getIndex(item.state.id);
    if (0 <= i - 1 && state.items[i - 1] is ArrowCubit) {
      if (i + 1 < state.items.length && state.items[i + 1] is ArrowCubit) {
        var leftDir = (state.items[i - 1] as ArrowCubit).state.direction;
        var rightDir = (state.items[i + 1] as ArrowCubit).state.direction;
        if (leftDir != rightDir) {
          if (i + 2 < state.items.length && state.items[i + 2] is FloorCubit) {
            state.items.removeAt(i + 2);
          }
          state.items.removeAt(i + 1);
          state.items.removeAt(i);
          state.items.removeAt(i - 1);
        }
      }
    }
  }

  Future<bool> tryPerformMerge(FloorCubit item) async {
    tryMerge(item, state);
    await Future.delayed(const Duration(milliseconds: 200));
    tryFinishMerge(item, state);
    return true;
    // emit(state.copy());
  }
}
