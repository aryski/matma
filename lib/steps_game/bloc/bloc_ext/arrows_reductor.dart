import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/filling_updater.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension ArrowsReductor on StepsGameBloc {
  Future<void> handleReduction(FloorCubit item, double delta,
      StepsGameState state, Emitter<StepsGameState> emit) async {
    var number = state.getNumberFromItem(item);
    if (number != null && number.filling != null) {
      number.filling?.animateToLeft();
    }
    animateLeftFilling(item, false);
    animateRightFilling(item, false);
    await reduceStepAndStepToTheRight(state.getStep(item), 200);
    if (allowedOps.contains(StepsGameOps.reducingArrowsCascadedly)) {
      if (number != null && number.filling != null) {
        for (int i = number.steps.length - 1; i >= 0; i--) {
          var step = number.steps[i];
          var rightStep = state.rightStep(step);
          if (rightStep != null) {
            await reduceStepAndStepToTheRight(step, i == 0 ? 150 : 70);
          }
        }
      }
    }

    taskCubit.merged();
    generateFillings();
    // beforeEmit();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> reduceStepAndStepToTheRight(
      StepsGameDefaultItem? step, int milliseconds) async {
    if (step != null) {
      var rightStep = state.rightStep(step);
      if (rightStep != null) {
        animateStepFold(step.floor, step.arrow, rightStep.arrow, milliseconds);
        await performReduction(step.floor, step, rightStep, milliseconds);
      }
    }
  }

  void animateStepFold(
      FloorCubit floor, ArrowCubit left, ArrowCubit right, int milliseconds) {
    var all = <GameItemCubit>{left, right, floor};
    var arrows = <ArrowCubit>{left, right};
    if (floor.state.direction == Direction.up) {
      for (var element in all) {
        element.updatePosition(Offset(0, gs.hUnit), milliseconds: milliseconds);
      }
    } else {
      floor.updatePosition(Offset(0, -gs.hUnit), milliseconds: milliseconds);
    }
    for (var e in arrows) {
      e.updateHeight(-gs.arrowH, milliseconds);
    }
    for (var e in arrows) {
      e.animate(0);
    }
    for (var e in all) {
      e.setOpacity(0, milliseconds: milliseconds);
    }
    var delta = -floor.state.size.value.dx;
    floor.updateSize(Offset(delta + gs.wUnit / 4, 0), milliseconds);
    print("REDUCTOR");

    state.updatePositionSince(
        item: floor,
        offset: Offset(delta + gs.wUnit / 4, 0),
        fillingIncluded: false,
        milliseconds: milliseconds);
  }

  Future<void> performReduction(FloorCubit floor, StepsGameDefaultItem step,
      StepsGameDefaultItem rightStep, int milliseconds) async {
    var leftStep = state.leftStep(step);
    _animateFloorsMerge(rightStep, leftStep, step, milliseconds);
    await Future.delayed(Duration(milliseconds: milliseconds));
    _updateEquationBoard(step, rightStep);
    state.removeStep(step);
    state.removeStep(rightStep);
    _updateLastness(leftStep);
  }

  void _animateFloorsMerge(
      StepsGameDefaultItem rightStep,
      StepsGameDefaultItem? leftStep,
      StepsGameDefaultItem step,
      int milliseconds) {
    var inheritedWidth = 0.0;
    inheritedWidth =
        rightStep.floor.state.size.value.dx - gs.wUnit / 2 + gs.wUnit / 4;

    if (leftStep != null && !state.isLastItem(rightStep.floor)) {
      leftStep.floor.updateSize(Offset(inheritedWidth, 0), milliseconds);
    }
    if (state.isFirstStep(step)) {
      state.updatePositionSince(
          item: rightStep.floor,
          offset: Offset(
              -rightStep.floor.state.size.value.dx + 1 / 2 * gs.wUnit, 0),
          milliseconds: milliseconds);
    }
    rightStep.floor.updateSize(
        Offset(-rightStep.floor.state.size.value.dx, 0), milliseconds);
    rightStep.floor.setOpacity(0);
  }

  void _updateEquationBoard(
      StepsGameDefaultItem step, StepsGameDefaultItem rightStep) {
    var indLeft = state.getNumberIndexFromStep(step);
    var indRight = state.getNumberIndexFromStep(rightStep);
    if (indLeft != null && indRight != null) {
      board.add(
          EquationEventNumbersReduction(indLeft: indLeft, indRight: indRight));
    }
  }

  void _updateLastness(StepsGameDefaultItem? leftStep) {
    if (leftStep != null) {
      leftStep.floor.setLastInNumber();
    }
    if (leftStep != null && state.isLastItem(leftStep.floor)) {
      leftStep.floor.updateSize(
          Offset(-leftStep.floor.state.size.value.dx + 1.25 * gs.wUnit, 0),
          200);
      leftStep.floor.setLastInGame();
    }
  }
}
