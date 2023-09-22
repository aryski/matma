import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/items_merger.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/simulation_items_generator.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';

extension ScrollHandler on StepsSimulationProBloc {
  Future<void> handleScroll(
      StepsSimulationProState state,
      StepsSimulationProEventScroll event,
      SimulationSize simSize,
      Emitter<StepsSimulationProState> emit) async {
    var item =
        state.items.firstWhere((element) => element.state.id == event.id);
    var minWidth = simSize.wUnit / 2;
    var defaultWidth = 1.25 * simSize.wUnit;
    bool isReducable = isMergeCandidate(item, state);
    if (item is FloorCubit && item.state.opacity > 0) {
      var delta = event.dy;
      //adjusting delta, so the width is at least endW
      var currentWidth = item.state.size.dx;
      if (isReducable) {
        if (currentWidth + delta < defaultWidth) {
          delta = -currentWidth;
        }
      } else {
        if (currentWidth + delta < minWidth) {
          delta = minWidth - currentWidth;
        }
      }
      item.updateSize(Offset(delta, 0));
      state.moveAllSince(item, Offset(delta, 0));
      if (isReducable) {
        if (currentWidth + delta < defaultWidth) {
          await tryPerformMerge(item);
        }
      }
      emit(state.copy());
    }
  }

  List<int> currentNumbers() {
    BoardVisualizer vis = BoardVisualizer();
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item is ArrowCubit && (item as ArrowCubit).state.opacity == 1.0) {
        var direction = item.state.direction;
        if (direction == Direction.up) {
          if (vis.value < 0) {
            if (vis.value == 1) {}
            vis.save();
          }
          vis.value += 1;
        } else if (direction == Direction.down) {
          if (vis.value > 0) {
            vis.save();
          }
          vis.value -= 1;
        }
      } else if (item is FloorCubit &&
          (item as FloorCubit).state.opacity == 1.0) {
        //TODO opacity
        if (item.state.size.dx > simSize.wUnit * 1.25) {
          vis.save();
        }
      }
    }
    vis.save();

    return vis.results;
  }
}

class BoardVisualizer {
  int value = 0;
  List<int> results = [];
  void save() {
    if (value != 0) results.add(value);
    value = 0;
  }
}
