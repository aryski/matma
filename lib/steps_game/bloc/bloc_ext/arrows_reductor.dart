import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension ArrowsReductor on StepsGameBloc {
  Future<void> handleReduction(FloorCubit item, double delta,
      StepsGameState state, Emitter<StepsGameState> emit) async {
    var currentWidth = item.state.size.dx;
    delta = -currentWidth;
    item.updateSize(Offset(delta, 0));
    state.updatePositionSince(item, Offset(delta, 0));
    currentWidth = item.state.size.dx;
    var step = state.getStep(item);
    if (step == null) return;
    var rightStep = state.rightStep(step);
    if (rightStep == null) return;
    animateStepFold(item, step.arrow, rightStep.arrow);
    await performReduction(item, step, rightStep);
    taskCubit.merged();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 200));
  }

  void animateStepFold(FloorCubit floor, ArrowCubit left, ArrowCubit right) {
    var all = <GameItemCubit>{left, right, floor};
    var arrows = <ArrowCubit>{left, right};
    if (floor.state.direction == Direction.up) {
      all.forEach((element) => element.updatePosition(Offset(0, gs.hUnit)));
    } else {
      floor.updatePosition(Offset(0, -gs.hUnit));
    }
    arrows.forEach((e) => e.updateHeight(-gs.arrowH));
    arrows.forEach((e) => e.animate(0));
    all.forEach((e) => e.setOpacity(0));
    floor.updateSize(Offset(-floor.state.size.dx, 0));
  }

  Future<void> performReduction(FloorCubit floor, StepsGameDefaultItem step,
      StepsGameDefaultItem rightStep) async {
    var leftStep = state.leftStep(step);
    _animateFloorsMerge(rightStep, leftStep, step);
    await Future.delayed(const Duration(milliseconds: 200));
    _updateEquationBoard(step, rightStep);
    state.removeStep(step);
    state.removeStep(rightStep);
    _updateLastness(leftStep);
  }

  void _animateFloorsMerge(StepsGameDefaultItem rightStep,
      StepsGameDefaultItem? leftStep, StepsGameDefaultItem step) {
    var inheritedWidth = 0.0;
    inheritedWidth = rightStep.floor.state.size.dx - gs.wUnit / 2;

    if (leftStep != null && !state.isLastItem(rightStep.floor)) {
      leftStep.floor.updateSize(Offset(inheritedWidth, 0));
    }
    if (state.isFirstStep(step)) {
      state.updatePositionSince(rightStep.floor,
          Offset(-rightStep.floor.state.size.dx + 1 / 2 * gs.wUnit, 0));
    }
    rightStep.floor.updateSize(Offset(-rightStep.floor.state.size.dx, 0));
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
          Offset(-leftStep.floor.state.size.dx + 1.25 * gs.wUnit, 0));
      leftStep.floor.setLastInGame();
    }
  }
}
