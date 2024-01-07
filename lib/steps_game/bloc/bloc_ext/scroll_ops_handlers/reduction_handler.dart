part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ReductionHandler on StepsGameBloc {
  Future<void> handleReduction(FloorCubit item, double delta,
      StepsGameState state, Emitter<StepsGameState> emit) async {
    if (allowedOps.contains(StepsGameOps.reduceArrows)) {
      var defOneReductionDuration = 200;
      var firstTime =
          (defOneReductionDuration * constants.firstTimeRatio).toInt();
      var othersTime =
          (defOneReductionDuration * constants.othersTimeRatio).toInt();
      var number = state.getNumberFromItem(item);
      var ind = state.getNumberIndexFromItem(item);
      if (number != null && ind != null) {
        number.filling?.animateFoldFull(millis: defOneReductionDuration);
        var leftNumber = (ind - 1 >= 0) ? state.numbers[ind - 1] : null;
        animateLeftFilling(item, false, defOneReductionDuration);
        animateRightFilling(item, false, defOneReductionDuration);
        await reduceStepAndStepToTheRight(
            state.getStep(item), defOneReductionDuration);
        if (allowedOps.contains(StepsGameOps.reducingArrowsCascadedly)) {
          if (number.filling != null) {
            for (int i = number.steps.length - 1; i >= 0; i--) {
              var step = number.steps[i];
              var rightStep = state.rightStep(step);
              if (rightStep != null) {
                await reduceStepAndStepToTheRight(
                    step, i == 0 ? firstTime : othersTime);
              }
            }
          }
        }
        if (leftNumber != null) {
          leftNumber.filling = null;
        }
        var millis = 200;
        questsBloc.add(TrigEventMerged());
        generateFillings(millis);
        emit(state.copy());
        await Future.delayed(Duration(milliseconds: millis));
      }
    }
  }

  Future<void> reduceStepAndStepToTheRight(
      StepsGameStep? step, int millis) async {
    if (step != null) {
      var rightStep = state.rightStep(step);
      if (rightStep != null) {
        _animateStepFold(step.floor, step.arrow, rightStep.arrow, millis);
        await _performReduction(step.floor, step, rightStep, millis);
      }
    }
  }

  void _animateStepFold(
      FloorCubit floor, ArrowCubit left, ArrowCubit right, int millis) {
    var all = <GameItemCubit>{left, right, floor};
    var arrows = <ArrowCubit>{left, right};
    if (floor.state.direction == Direction.up) {
      for (var element in all) {
        element.updatePosition(const Offset(0, constants.arrowH),
            millis: millis);
      }
    } else {
      floor.updatePosition(const Offset(0, -constants.arrowH), millis: millis);
    }
    for (var e in arrows) {
      e.updateHeight(-constants.arrowH, millis);
    }
    for (var e in arrows) {
      e.animate(0);
    }
    for (var e in all) {
      e.setOpacity(0, millis: millis);
    }
    var delta = -floor.state.size.value.dx;
    floor.updateSize(Offset(delta + constants.arrowW / 4, 0), millis: millis);
    updatePositionSince(
        item: floor,
        offset: Offset(delta + constants.arrowW / 4, 0),
        fillingIncluded: false,
        millis: millis);
  }

  Future<void> _performReduction(FloorCubit floor, StepsGameStep step,
      StepsGameStep rightStep, int millis) async {
    var leftStep = state.leftStep(step);
    _animateFloorsMerge(rightStep, leftStep, step, millis);
    await Future.delayed(Duration(milliseconds: millis));
    _updateEquationBoard(step, rightStep);
    state.removeStep(step);
    state.removeStep(rightStep);
    _updateLastness(leftStep);
  }

  void _animateFloorsMerge(StepsGameStep rightStep, StepsGameStep? leftStep,
      StepsGameStep step, int millis) {
    rightStep.floor.setLastInNumber();
    leftStep?.floor.setLastInNumber();
    var inheritedWidth = 0.0;
    inheritedWidth = rightStep.floor.state.size.value.dx -
        constants.arrowW / 2 +
        constants.arrowW / 4;

    if (leftStep != null && !state.isLastItem(rightStep.floor)) {
      leftStep.floor.updateSize(Offset(inheritedWidth, 0), millis: millis);
    }
    if (state.isFirstStep(step)) {
      updatePositionSince(
          item: rightStep.floor,
          offset: Offset(
              -rightStep.floor.state.size.value.dx + 1 / 2 * constants.arrowW,
              0),
          millis: millis);
    }
    if (leftStep == null) {
      rightStep.floor.updateSize(
          Offset(-rightStep.floor.state.size.value.dx, 0),
          millis: millis);
    }

    rightStep.floor.setOpacity(0, delayInMillis: millis, millis: 0);
  }

  void _updateEquationBoard(StepsGameStep step, StepsGameStep rightStep) {
    var indLeft = state.getNumberIndexFromStep(step);
    var indRight = state.getNumberIndexFromStep(rightStep);
    if (indLeft != null && indRight != null) {
      board.add(EquationEventNumbersReduction(lInd: indLeft, rInd: indRight));
    }
  }

  void _updateLastness(StepsGameStep? leftStep) {
    if (leftStep != null) {
      leftStep.floor.setLastInNumber();
    }
    if (leftStep != null && state.isLastItem(leftStep.floor)) {
      leftStep.floor.updateSize(
          Offset(
              -leftStep.floor.state.size.value.dx + 1.25 * constants.arrowW, 0),
          millis: 200);
      leftStep.floor.setLastInGame();
    }
  }
}
