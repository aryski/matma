part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ArrowInsertor on StepsGameBloc {
  Future<void> handleArrowInsertion(
      StepsTrigEventClickUpArrow event,
      Emitter<StepsGameState> emit,
      EquationBloc board,
      QuestsBloc questsBloc) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      updateStepHgt(
          item: item,
          delta: constants.arrowReleasedHgt - constants.arrowClickedHgt,
          milliseconds: 200);
      await Future.delayed(const Duration(milliseconds: 200));

      var newStep = _insertStep(item, item.state.direction, 200);
      _replaceStep(state.getStep(item), item.state.direction);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));

      _animateNewStep(newStep, 200);
      if (item.state.direction == Direction.up) {
        questsBloc.add(TrigEventInsertedUp());
      } else {
        questsBloc.add(TrigEventInsertedDown());
      }
      generateFillings(200);
      emit(state.copy());
    }
  }

  StepsGameStep _insertStep(
      GameItemCubit<GameItemState> item, Direction dir, int milliseconds) {
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
        milliseconds: milliseconds);

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

  void _animateNewStep(StepsGameStep newStep, int milliseconds) {
    newStep.arrow.animate(1);
    var delta = constants.floorWDef - constants.floorWMini;
    newStep.floor.updateSize(Offset(delta, 0), milliseconds: milliseconds);
    updatePositionSince(
        item: newStep.floor,
        offset: Offset(delta, 0),
        milliseconds: milliseconds);
  }
}
