import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/quests/cubit/quests_cubit.dart';

extension ArrowInsertor on StepsGameBloc {
  Future<void> handleArrowInsertion(
      StepsGameEventPointerUp event,
      Emitter<StepsGameState> emit,
      EquationBloc board,
      QuestsCubit taskCubit) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      item.updateHeight(3 * simSize.hRatio / 2);
      if (item.state.direction == Direction.down) {
        state.moveAllSince(item, Offset(0, 3 * simSize.hRatio / 2));
      } else {
        state.moveAllSinceIncluded(item, Offset(0, -simSize.hRatio * 3 / 2));
      }
      // //here next click, przydaloby sie usunac te delayed TODO
      await Future.delayed(const Duration(milliseconds: 200));
      var inserted = _insertArrow(item, item.state.direction);
      var step = state.getStep(item);
      //replace whole step
      if (step != null) {
        StepsGameDefaultItem? newStep;
        if (item.state.direction == Direction.up) {
          newStep = StepsGameDefaultItem(
              arrow: generateArrowUp(position: item.state.position),
              floor: step.floor);
        } else if (item.state.direction == Direction.down) {
          newStep = StepsGameDefaultItem(
              arrow: generateArrowDown(
                  position: item.state.position + Offset(0, simSize.hRatio)),
              floor: step.floor);
        }

        if (newStep != null) {
          state.replaceStep(step, newStep);
        }
      }
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      //animate scroll
      inserted.arrow.animate(1);
      var delta = simSize.wRatio;
      inserted.floor.updateSize(Offset(delta, 0));
      state.moveAllSince(inserted.floor, Offset(delta, 0));
      taskCubit.inserted(item.state.direction);
    }
  }

  StepsGameDefaultItem _insertArrow(
      GameItemCubit<GameItemState> item, Direction direction) {
    var currentLeft = item.state.position.dx;
    var currentTop = item.state.position.dy;
    var pos = Offset(currentLeft, currentTop);
    late ArrowCubit arrow1;
    late FloorCubit floor;
    if (direction == Direction.up) {
      arrow1 = generateArrowUp(
          position: pos,
          delta: Offset(0, simSize.hRatio),
          animationProgress: 0);
      floor = generateFloor(
          direction: Direction.up,
          position: pos,
          delta: Offset(simSize.wRatio / 2, simSize.hRatio),
          widthRatio: 0.25);
    } else {
      arrow1 = generateArrowDown(
          position: pos, delta: Offset.zero, animationProgress: 0);
      floor = generateFloor(
          direction: Direction.down,
          position: pos,
          delta:
              Offset(simSize.wRatio / 2, simSize.hRatio - simSize.hRatio / 5),
          widthRatio: 0.25);
    }
    var stepsDefault = StepsGameDefaultItem(arrow: arrow1, floor: floor);

    for (int i = 0; i < state.numbers.length; i++) {
      var number = state.numbers[i];

      for (int j = 0; j < number.steps.length; j++) {
        if (number.steps[j].arrow == item) {
          number.steps.insert(j, stepsDefault);
          board.add(EquationEventIncreaseNumber(ind: i));
          break;
        }
      }
    }

    return stepsDefault;
  }

  Future<bool> handleOppositeInsertion(
      StepsGameState state,
      GameItemCubit? item,
      SimulationSize simSize,
      Emitter<StepsGameState> emit) async {
    if (item is! FloorCubit || !(state.isLastItem(item))) return false;
    var step = state.getStep(item);
    if (step == null) return false;
    var dir = step.arrow.state.direction;
    ArrowCubit arrow;
    FloorCubit floor;
    if (dir == Direction.up) {
      board.add(EquationEventAddNumber(value: -1));
      arrow = generateArrowDown(
          animationProgress: 0,
          position: item.state.position +
              Offset(simSize.wRatio * 0.5, 0 + simSize.hRatio / 5),
          size: Offset(simSize.wRatio, 0));
      floor = generateFloor(
          direction: Direction.down,
          position: item.state.position + Offset(simSize.wRatio * 1, 0),
          size: Offset(0, simSize.hRatio / 5));
    } else {
      board.add(EquationEventAddNumber(value: 1));
      arrow = generateArrowUp(
          animationProgress: 0.0,
          position: item.state.position + Offset(simSize.wRatio * 0.5, 0),
          size: Offset(simSize.wRatio, 0));
      floor = generateFloor(
          direction: Direction.up,
          position: item.state.position + Offset(simSize.wRatio * 1, 0),
          size: Offset(0, simSize.hRatio / 5));
    }
    state.numbers.add(StepsGameNumberState(
        [StepsGameDefaultItem(arrow: arrow, floor: floor)]));
    taskCubit.insertedOpposite();
    item.setLast();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 20));
    if (dir == Direction.up) {
      floor.updatePosition(Offset(0, simSize.hRatio));
    } else {
      arrow.updatePosition(Offset(0, -simSize.hRatio));
      floor.updatePosition(Offset(0, -simSize.hRatio));
    }

    floor.updateSizeDelayed(
        const Duration(milliseconds: 200), Offset(1.25 * simSize.wRatio, 0));
    arrow.animate(1.0);
    arrow.updateHeight(simSize.hRatio);

    floor.setLastLast();
    item.setNotLastLast();
    return true;
  }
}
