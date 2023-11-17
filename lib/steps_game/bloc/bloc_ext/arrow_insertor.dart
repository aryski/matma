import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/prompts/cubit/quests_cubit.dart';

extension ArrowInsertor on StepsGameBloc {
  Future<void> handleArrowInsertion(
      StepsGameEventClickUp event,
      Emitter<StepsGameState> emit,
      EquationBloc board,
      QuestsCubit taskCubit) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      bool isUp = (item.state.direction == Direction.up);
      state.updateStepHgt(
          item: item,
          delta: gs.arrowReleasedHgt - gs.arrowClickedHgt,
          milliseconds: 200);
      await Future.delayed(const Duration(milliseconds: 200));
      var newStep = _insertStep(item, isUp);
      _replaceStep(state.getStep(item), isUp);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      _animateNewStep(newStep, 200);
      taskCubit.inserted(item.state.direction);
      generateFillings();
      emit(state.copy());
    }
  }

  StepsGameDefaultItem _insertStep(
      GameItemCubit<GameItemState> item, bool isUp) {
    var pos =
        Offset(item.state.position.value.dx, item.state.position.value.dy);
    ArrowCubit arrow = generateArrow(
        position: pos + Offset(0, isUp ? gs.hUnit : 0),
        animationProgress: 0,
        direction: isUp ? Direction.up : Direction.down);
    FloorCubit floor = generateFloor(
        direction: isUp ? Direction.up : Direction.down,
        position: pos,
        widthSize: gs.floorWMini);
    floor.updatePosition(
        Offset(gs.wUnit / 2, isUp ? gs.hUnit : (gs.hUnit - gs.floorH)));

    var stepsDefault = StepsGameDefaultItem(arrow: arrow, floor: floor);
    int? ind = state.getNumberIndexFromItem(item);
    var step = state.getStep(item);
    if (ind != null && step != null) {
      state.insertStepAt(step, stepsDefault);
      board.add(EquationEventIncreaseNumber(ind: ind));
    }
    return stepsDefault;
  }

  void _replaceStep(StepsGameDefaultItem? step, bool isUp) {
    if (step != null) {
      StepsGameDefaultItem? newStep;
      newStep = StepsGameDefaultItem(
          arrow: generateArrow(
              position: step.arrow.state.position.value +
                  Offset(0, isUp ? 0 : gs.hUnit),
              direction: isUp ? Direction.up : Direction.down),
          floor: step.floor);
      state.replaceStep(step, newStep);
    }
  }

  void _animateNewStep(StepsGameDefaultItem newStep, int milliseconds) {
    newStep.arrow.animate(1);
    var delta = gs.wUnit;
    newStep.floor.updateSize(Offset(delta, 0), milliseconds);
    state.updatePositionSince(
        item: newStep.floor,
        offset: Offset(delta, 0),
        milliseconds: milliseconds);
  }
}
