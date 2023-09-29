import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/items_merger.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation/items/floor/presentation/floor.dart';

extension ScrollHandler on StepsSimulationBloc {
  Future<void> handleScroll(
      StepsSimulationState state,
      StepsSimulationEventScroll event,
      SimulationSize simSize,
      Emitter<StepsSimulationState> emit) async {
    var item = state.getItem(event.id);

    var minWidth = simSize.wUnit * 1.25;
    var defaultWidth = 1.25 * simSize.wUnit;
    bool isReducable = isMergeCandidate(item, state);
    var delta = -event.dy;
    if (item is FloorCubit && state.isLastItem(item)) {
      var step = state.getStep(item);
      if (step != null) {
        var dir = step.arrow.state.direction;
        ArrowCubit arrow;
        FloorCubit floor;
        if (dir == Direction.up) {
          arrow = generateArrowDown(
              position: item.state.position +
                  Offset(simSize.wUnit * 0.5,
                      simSize.hUnit + simSize.hUnit / 5)) as ArrowCubit;
          floor = generateFloor(
                  position: item.state.position +
                      Offset(simSize.wUnit * 1, simSize.hUnit + simSize.hUnit))
              as FloorCubit;
        } else {
          arrow = generateArrowUp(
              position: item.state.position +
                  Offset(simSize.wUnit * 0.5, 0)) as ArrowCubit;
          floor = generateFloor(
                  position: item.state.position + Offset(simSize.wUnit * 1, 0))
              as FloorCubit;
        }
        //generate animation and arrow in opposite direction;
        //walisz insert arrow i wyrasta z podziemi nie wiadomo co a potem wyrasta jej zolty kikut a ten aktualny zmienia swoj kolor xD
        //zmiana koloru na koniec
        state.numbers.add(StepsSimulationNumberState(
            [StepsSimulationDefaultItem(arrow: arrow, floor: floor)]));

        emit(state.copy());
        await Future.delayed(Duration(milliseconds: 20));
        arrow.updatePosition(Offset(0, -simSize.hUnit));
        floor.updatePosition(Offset(0, -simSize.hUnit));
        floor.updateColor(defaultYellow, darkenColor(defaultYellow, 20));
        item.updateColor(defaultGrey, darkenColor(defaultGrey, 20));
        // arrow.updateHeight(1 / 2 * simSize.hUnit);
        // arrow.animate(1);
      }
    } else {
      if (isReducable) {
        if (item is FloorCubit && item.state.opacity > 0) {
          await handleMerge(item, delta, defaultWidth, state, emit);
        }
      } else {
        if (item is FloorCubit && item.state.opacity > 0) {
          //adjusting delta, so the width is at least endW
          handleSplitJoin(item, delta, minWidth, simSize, state, emit);
        }
      }
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }

  void handleSplitJoin(
      FloorCubit item,
      double delta,
      double minWidth,
      SimulationSize simSize,
      StepsSimulationState state,
      Emitter<StepsSimulationState> emit) {
    // adjusting delta, so the width is at least endW
    var currentWidth = item.state.size.dx;
    if (currentWidth + delta < minWidth) {
      delta = minWidth - currentWidth;
    }

    item.updateSize(Offset(delta, 0));
    if (item.state.size.dx > 1.25 * simSize.wUnit) {
      var myStep = state.getStep(item);
      if (myStep != null) {
        int? numberInd = state.getNumberIndex(myStep);
        if (numberInd != null) {
          var number = state.numbers[numberInd];
          //todo split number at
          if (number.steps.last != myStep) {
            List<StepsSimulationDefaultItem> left = [];
            List<StepsSimulationDefaultItem> right = [];
            List<StepsSimulationDefaultItem> current = left;
            bool changed = false;
            for (var step in number.steps) {
              current.add(step);
              if (!changed && step == myStep) {
                current = right;
                changed = true;
              }
            }
            state.numbers[numberInd].steps.clear();
            state.numbers[numberInd].steps.addAll(left);
            state.numbers
                .insert(numberInd + 1, StepsSimulationNumberState(right));
            board.add(EquationBoardEventSplitNumber(
                ind: numberInd,
                leftValue: state.numbers[numberInd].number,
                rightValue: state.numbers[numberInd + 1].number));
            taskCubit.splited();
          }
        }
      }
    }
    print(item.state.size.dx);
    print(1.25 * simSize.wUnit);
    if (item.state.size.dx <= 1.25 * simSize.wUnit) {
      var step = state.getStep(item);
      if (step != null) {
        int? numberInd = state.getNumberIndex(step);

        if (numberInd != null) {
          int? nextInd = numberInd + 1;
          if (nextInd < state.numbers.length) {
            var number = state.numbers[numberInd];
            var nextNumber = state.numbers[nextInd];
            if (number.number * nextNumber.number > 0) {
              //same sign trzeba zmergowac TODO bledy czasem
              board.add(EquationBoardEventJoinNumbers(
                  leftInd: numberInd, rightInd: nextInd));
              number.steps.addAll(nextNumber.steps);
              state.numbers.remove(nextNumber);
            }
          }
        }
      }
    }
    if (delta != 0) {
      taskCubit.scrolled();
    }
    state.moveAllSince(item, Offset(delta, 0));
    emit(state.copy());
  }

  Future<void> handleMerge(FloorCubit item, double delta, double defaultWidth,
      StepsSimulationState state, Emitter<StepsSimulationState> emit) async {
    var currentWidth = item.state.size.dx;
    if (currentWidth + delta < defaultWidth) {
      delta = -currentWidth; //zerujemy dlugosc
    }
    item.updateSize(Offset(delta, 0));
    state.moveAllSince(item, Offset(delta, 0));
    if (currentWidth + delta < defaultWidth) {
      var result = await tryMerge(item);
      if (result) {
        taskCubit.merged();
      }
    }
    emit(state.copy());
  }
}
