import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

DateTime _globalTime = DateTime.now();

extension ArrowsReductor on StepsGameBloc {
  Future<bool> handleReduction(
      GameItemCubit? item,
      double delta,
      double defaultWidth,
      StepsGameState state,
      Emitter<StepsGameState> emit) async {
    if (!areNeighborsOpposite(item, state) ||
        item is! FloorCubit ||
        item.state.opacity <= 0) {
      return false;
    }

    if (DateTime.now().difference(_globalTime).inMilliseconds < 300) {
      //neutralizing when scroll wants to resize to defaultWidth and do reduction at the same time
      _globalTime == DateTime.now();
      delta = 0;
    }

    var currentWidth = item.state.size.dx;
    if (currentWidth == defaultWidth && currentWidth + delta < defaultWidth) {
      delta = -currentWidth; //zerujemy dlugosc
    } else if (currentWidth + delta < defaultWidth) {
      _globalTime = DateTime.now();
      //neutralizing when scroll wants to resize to defaultWidth and do reduction at the same time
      delta = defaultWidth - currentWidth;
    }

    item.updateSize(Offset(delta, 0));
    state.moveAllSince(item, Offset(delta, 0));
    if (currentWidth == defaultWidth && currentWidth + delta < defaultWidth) {
      var step = state.getStep(item);
      if (step == null) return false;
      var rightStep = state.rightStep(step);
      if (rightStep == null) return false;
      await performReduction(item, step, rightStep);
      taskCubit.merged();
    }
    emit(state.copy());
    return true;
  }

  bool areNeighborsOpposite(GameItemCubit? item, StepsGameState state) {
    if (item is FloorCubit) {
      var step = state.getStep(item);
      if (step == null) return false;
      var rightStep = state.rightStep(step);
      if (rightStep == null) return false;
      var left = step.arrow;
      var right = rightStep.arrow;
      if (left.state.direction != right.state.direction) {
        return true;
      }
    }
    return false;
  }

  Future<void> performReduction(FloorCubit floor, StepsGameDefaultItem step,
      StepsGameDefaultItem rightStep) async {
    var mid = step.arrow;
    var right = rightStep.arrow;

    mid.updatePosition(Offset(0, gs.hUnit));
    right.updatePosition(Offset(0, gs.hUnit));
    floor.updatePosition(Offset(0, gs.hUnit));
    mid.setOpacity(0);
    right.setOpacity(0);
    floor.setOpacity(0);

    var inheritedWidth = 0.0;
    inheritedWidth = rightStep.floor.state.size.dx - gs.wUnit / 2;
    var leftStep = state.leftStep(step);
    if (leftStep != null && !state.isLastItem(rightStep.floor)) {
      leftStep.floor.updateSize(Offset(inheritedWidth, 0));
    }
    if (state.isFirstStep(step)) {
      state.moveAllSince(rightStep.floor,
          Offset(-rightStep.floor.state.size.dx + 1 / 2 * gs.wUnit, 0));
    }
    rightStep.floor.updateSize(Offset(-rightStep.floor.state.size.dx, 0));
    rightStep.floor.setOpacity(0);

    await Future.delayed(const Duration(milliseconds: 200));
    var indLeft = state.getNumberIndexFromStep(step);
    var indRight = state.getNumberIndexFromStep(rightStep);
    if (indLeft != null && indRight != null) {
      board.add(
          EquationEventNumbersReduction(indLeft: indLeft, indRight: indRight));
    }

    state.removeStep(step);
    state.removeStep(rightStep);
    if (leftStep != null) {
      leftStep.floor.setLast();
    }
    if (leftStep != null && state.isLastItem(leftStep.floor)) {
      leftStep.floor.updateSize(
          Offset(-leftStep.floor.state.size.dx + 1.25 * gs.wUnit, 0));
      leftStep.floor.setLastLast();
    }
  }
}
