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
      bool isUp = (item.state.direction == Direction.up);
      _animateVerticalExpension(item);
      await Future.delayed(const Duration(milliseconds: 200));
      var newStep = _insertStep(item, isUp);
      _replaceStep(state.getStep(item), isUp);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      _animateNewStep(newStep);
      taskCubit.inserted(item.state.direction);
    }
  }

  StepsGameDefaultItem _insertStep(
      GameItemCubit<GameItemState> item, bool isUp) {
    var pos = Offset(item.state.position.dx, item.state.position.dy);
    ArrowCubit arrow = generateArrow(
        position: pos,
        delta: Offset(0, isUp ? gs.hUnit : 0),
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

  void _animateVerticalExpension(ArrowCubit item) {
    var arrowHgtDelta = gs.arrowReleasedHgt - gs.arrowClickedHgt;
    item.updateHeight(arrowHgtDelta);
    if (item.state.direction == Direction.down) {
      state.moveAllSince(item, Offset(0, arrowHgtDelta));
    } else {
      state.moveAllSinceIncluded(item, Offset(0, -arrowHgtDelta));
    }
  }

  void _replaceStep(StepsGameDefaultItem? step, bool isUp) {
    if (step != null) {
      StepsGameDefaultItem? newStep;
      newStep = StepsGameDefaultItem(
          arrow: generateArrow(
              position:
                  step.arrow.state.position + Offset(0, isUp ? 0 : gs.hUnit),
              direction: isUp ? Direction.up : Direction.down),
          floor: step.floor);
      state.replaceStep(step, newStep);
    }
  }

  void _animateNewStep(StepsGameDefaultItem newStep) {
    newStep.arrow.animate(1);
    var delta = gs.wUnit;
    newStep.floor.updateSize(Offset(delta, 0));
    state.moveAllSince(newStep.floor, Offset(delta, 0));
  }
}
