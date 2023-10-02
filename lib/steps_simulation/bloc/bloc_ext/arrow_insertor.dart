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
    print("start: $event");
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      item.updateHeight(3 * simSize.hUnit / 2);
      if (item.state.direction == Direction.down) {
        state.moveAllSince(item, Offset(0, 3 * simSize.hUnit / 2));
      } else {
        state.moveAllSinceIncluded(item, Offset(0, -simSize.hUnit * 3 / 2));
      }
      // //here next click, przydaloby sie usunac te delayed TODO
      await Future.delayed(const Duration(milliseconds: 200));
      var inserted = _insertArrow(item, item.state.direction);
      var step = state.getStep(item);
      //replace whole step
      if (step != null) {
        StepsSimulationDefaultItem? newStep;
        if (item.state.direction == Direction.up) {
          newStep = StepsSimulationDefaultItem(
              arrow: generateArrowUp(position: item.state.position),
              floor: step.floor
              // generateFloor(
              //     position:
              //         item.state.position + Offset(simSize.wUnit / 2, 0)),
              );
        } else if (item.state.direction == Direction.down) {
          newStep = StepsSimulationDefaultItem(
              arrow: generateArrowDown(
                  position: item.state.position + Offset(0, simSize.hUnit)),
              floor: step.floor
              // generateFloor(
              //     position: item.state.position +
              //         Offset(simSize.wUnit / 2,
              //             2 * simSize.hUnit - simSize.hUnit / 5)),
              );
        }

        if (newStep != null) {
          state.replaceStep(step, newStep);
        }
      }
      // item.updateHeight(-simSize.hUnit);
      // item.refreshHard;

      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      //animate scroll
      inserted.arrow.animate(1);
      var delta = simSize.wUnit;
      inserted.floor.updateSize(Offset(delta, 0));
      print("amigo");
      state.moveAllSince(inserted.floor, Offset(delta, 0));
      taskCubit.inserted(item.state.direction);
      print("end: $event");
    }
  }

  StepsSimulationDefaultItem _insertArrow(
      SimulationItemCubit<SimulationItemState> item, Direction direction) {
    var currentLeft = item.state.position.dx;
    var currentTop = item.state.position.dy;
    var pos = Offset(currentLeft, currentTop);
    late ArrowCubit arrow1;
    // late SimulationItemCubit arrow2;
    late FloorCubit floor;
    if (direction == Direction.up) {
      arrow1 = generateArrowUp(
          position: pos, delta: Offset(0, simSize.hUnit), animationProgress: 0);
      // arrow2 = generateArrowUp(position: pos, delta: Offset.zero);
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit),
          widthRatio: 0.25);
    } else {
      //wiec tak arrow 2 rozwiazac tak ze naprawic ta strzale co jest a nie replace walic xD

      arrow1 = generateArrowDown(
          position: pos, delta: Offset.zero, animationProgress: 0);
      // arrow2 =
      //     generateArrowDown(position: pos, delta: Offset(0, simSize.hUnit));
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit - simSize.hUnit / 5),
          widthRatio: 0.25);
    }
    var stepsDefault = StepsSimulationDefaultItem(arrow: arrow1, floor: floor);

    for (int i = 0; i < state.numbers.length; i++) {
      var number = state.numbers[i];

      for (int j = 0; j < number.steps.length; j++) {
        if (number.steps[j].arrow == item) {
          // if (number.steps[j].arrow.state.direction == Direction.down) {
          //   item.updatePosition(Offset(0, simSize.hUnit));
          // }
          number.steps.insert(j, stepsDefault);
          board.add(EquationBoardEventIncreaseNumber(ind: i));
          break;
        }
      }
    }

    return stepsDefault;
  }
}
