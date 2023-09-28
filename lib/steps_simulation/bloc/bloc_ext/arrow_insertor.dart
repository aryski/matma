import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';

extension ArrowInsertor on StepsSimulationBloc {
  Future<void> handleArrowInsertion(
      StepsSimulationEventPointerUp event,
      Emitter<StepsSimulationState> emit,
      EquationBoardBloc board,
      TaskSimulationCubit taskCubit) async {
    print("INSERT1");
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      item.updateHeight(3 * simSize.hUnit / 2);
      if (item.state.direction == Direction.down) {
        state.moveAllSince(item, Offset(0, 3 * simSize.hUnit / 2));
      } else {
        state.moveAllSinceIncluded(item, Offset(0, -simSize.hUnit * 3 / 2));
      }
      print("INSERT2"); //here next click, przydaloby sie usunac te delayed TODO
      await Future.delayed(const Duration(milliseconds: 200));
      var inserted = _insertArrow(item, item.state.direction);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      print("INSERT3");
      //animate scroll
      if (inserted[0] is ArrowCubit) {
        (inserted[0] as ArrowCubit).animate(1);
      }

      var delta = simSize.wUnit;
      if (inserted[1] is FloorCubit) {
        (inserted[1] as FloorCubit).updateSize(Offset(delta, 0));
        state.moveAllSince(inserted[1], Offset(delta, 0));
      }
      print("INSERT4");
      taskCubit.inserted(item.state.direction);
    }
  }

  List<SimulationItemCubit> _insertArrow(
      SimulationItemCubit<SimulationItemState> item, Direction direction) {
    var currentLeft = item.state.position.dx;
    var currentTop = item.state.position.dy;
    var pos = Offset(currentLeft, currentTop);
    late SimulationItemCubit arrow1;
    late SimulationItemCubit arrow2;
    late SimulationItemCubit floor;
    if (direction == Direction.up) {
      arrow1 = generateArrowUp(
          position: pos, delta: Offset(0, simSize.hUnit), animationProgress: 0);
      arrow2 = generateArrowUp(position: pos, delta: Offset.zero);
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit),
          widthRatio: 0.25);
    } else {
      arrow1 = generateArrowDown(
          position: pos, delta: Offset.zero, animationProgress: 0);
      arrow2 =
          generateArrowDown(position: pos, delta: Offset(0, simSize.hUnit));
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit - simSize.hUnit / 5),
          widthRatio: 0.25);
    }
    for (int i = 0; i < state.numbers.length; i++) {
      var number = state.numbers[i];
      if (number.items.contains(item)) {
        for (int j = 0; j < number.items.length; j++) {
          if (number.items[j] == item) {
            number.items.replaceRange(j, j + 1, [arrow1, floor, arrow2]);

            board.add(EquationBoardEventIncreaseNumber(ind: i));
            break;
          }
        }
      }
    }

    return [arrow1, floor, arrow2];
  }
}
