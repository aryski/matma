part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ArrowInsertor on StepsGameBloc {
  Future<void> handleArrowInsertion(
      StepsTrigEventClickUpArrow event,
      Emitter<StepsGameState> emit,
      EquationBloc board,
      QuestsBloc questsBloc,
      int millis) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      updateStepHgt(
          item: item,
          delta: constants.arrowReleasedHgt - constants.arrowClickedHgt,
          millis: 200);
      await Future.delayed(Duration(milliseconds: millis));

      var newStep = _insertStep(item, item.state.direction, millis);
      _replaceStep(state.getStep(item), item.state.direction);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));

      _animateNewStep(newStep, millis);
      if (item.state.direction == Direction.up) {
        questsBloc.add(TrigEventInsertedUp());
      } else {
        questsBloc.add(TrigEventInsertedDown());
      }
      generateFillings(millis);
      emit(state.copy());
    }
  }

  StepsGameStep _insertStep(
      GameItemCubit<GameItemState> item, Direction dir, int millis) {
    var pos =
        Offset(item.state.position.value.dx, item.state.position.value.dy);
    ArrowCubit arrow = generateArrow(
      position: pos + Offset(0, dir == Direction.up ? constants.arrowH : 0),
      animationProgress: 0,
      direction: dir,
    );
    FloorCubit floor = generateFloor(
        direction: dir, position: pos, widthSize: constants.floorWMini);
    floor.updatePosition(
        const Offset(constants.arrowW / 2, constants.arrowH) +
            Offset(0, dir == Direction.up ? 0 : -constants.floorH),
        millis: millis);

    var stepsDefault = StepsGameStep(arrow: arrow, floor: floor);
    int? ind = state.getNumberIndexFromItem(item);
    var step = state.getStep(item);
    if (ind != null && step != null) {
      state.insertStepAt(step, stepsDefault);
      board.add(EquationEventIncreaseNumber(ind: ind));
    }
    return stepsDefault;
  }

  void _replaceStep(StepsGameStep? step, Direction dir) {
    if (step != null) {
      StepsGameStep? newStep;
      newStep = StepsGameStep(
          arrow: generateArrow(
              position: step.arrow.state.position.value +
                  Offset(0, dir == Direction.up ? 0 : constants.arrowH),
              direction: dir),
          floor: step.floor);
      state.replaceStep(step, newStep);
    }
  }

  void _animateNewStep(StepsGameStep newStep, int millis) {
    newStep.arrow.animate(1);
    var delta = constants.floorWDef - constants.floorWMini;
    newStep.floor.updateSize(Offset(delta, 0), millis: millis);
    updatePositionSince(
        item: newStep.floor, offset: Offset(delta, 0), millis: millis);
  }
}
