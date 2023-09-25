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
    var item = state.getItem(event.id);
    var minWidth = simSize.wUnit / 2;
    var defaultWidth = 1.25 * simSize.wUnit;
    bool isReducable = isMergeCandidate(item, state);
    if (isReducable) {
      if (item is FloorCubit && item.state.opacity > 0) {
        var delta = event.dy;
        var currentWidth = item.state.size.dx;
        if (currentWidth + delta < defaultWidth) {
          delta = -currentWidth; //zerujemy dlugosc
        }
        item.updateSize(Offset(delta, 0));
        state.moveAllSince(item, Offset(delta, 0));
        if (currentWidth + delta < defaultWidth) {
          await tryMerge(item);
        }
        emit(state.copy());
      }
    } else {
      if (item is FloorCubit && item.state.opacity > 0) {
        var delta = event.dy;
        //adjusting delta, so the width is at least endW
        var currentWidth = item.state.size.dx;
        if (currentWidth + delta < minWidth) {
          delta = minWidth - currentWidth;
        }
        item.updateSize(Offset(delta, 0));
        state.moveAllSince(item, Offset(delta, 0));
        emit(state.copy());
      }
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}
