import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
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
    var minWidth = simSize.wUnit * 1.25;
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
        if (item.state.size.dx > 1.25 * simSize.wUnit) {
          //TODO
          //split if not splited
          int? numberInd = state.getNumberIndex(item);
          if (numberInd != null) {
            var number = state.numbers[numberInd];

            if (number.items.last != item) {
              List<SimulationItemCubit> left = [];
              List<SimulationItemCubit> right = [];
              bool split = false;
              for (int i = 0; i < number.items.length; i++) {
                if (!split) {
                  left.add(number.items[i]);
                } else {
                  right.add(number.items[i]);
                }
                if (!split && number.items[i] == item) {
                  split = true;
                }
              }
              state.numbers[numberInd].items.clear();
              state.numbers[numberInd].items.addAll(left);
              state.numbers
                  .insert(numberInd + 1, StepsSimulationProNumberState(right));

              board.add(EquationBoardEventSplitNumber(
                  ind: numberInd,
                  leftValue: state.numbers[numberInd].number,
                  rightValue: state.numbers[numberInd + 1].number));
            }
          }
        }
        state.moveAllSince(item, Offset(delta, 0));
        emit(state.copy());
      }
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}
