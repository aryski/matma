part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ArrowInsertor on StepsGameBloc {
  Future<void> handleArrowInsertion(
      StepsTrigEventClickUp event,
      Emitter<StepsGameState> emit,
      EquationBloc board,
      QuestsBloc questsBloc) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      bool isUp = (item.state.direction == Direction.up);
      state.updateStepHgt(
          item: item,
          delta: constants.arrowReleasedHgt - constants.arrowClickedHgt,
          milliseconds: 200);
      await Future.delayed(const Duration(milliseconds: 200));
      var newStep = _insertStep(item, isUp);
      _replaceStep(state.getStep(item), isUp);
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      _animateNewStep(newStep, 200);
      if (item.state.direction == Direction.up) {
        questsBloc.add(TrigEventInsertedUp());
      } else {
        questsBloc.add(TrigEventInsertedDown());
      }
      generateFillings();
      emit(state.copy());
    }
  }

  StepsGameDefaultItem _insertStep(
      GameItemCubit<GameItemState> item, bool isUp) {
    var pos =
        Offset(item.state.position.value.dx, item.state.position.value.dy);
    ArrowCubit arrow = generateArrow(
        position: pos + Offset(0, isUp ? constants.arrowH : 0),
        animationProgress: 0,
        direction: isUp ? Direction.up : Direction.down);
    FloorCubit floor = generateFloor(
        direction: isUp ? Direction.up : Direction.down,
        position: pos,
        widthSize: constants.floorWMini);
    floor.updatePosition(Offset(constants.arrowW / 2,
        isUp ? constants.arrowH : (constants.arrowH - constants.floorH)));

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
                  Offset(0, isUp ? 0 : constants.arrowH),
              direction: isUp ? Direction.up : Direction.down),
          floor: step.floor);
      state.replaceStep(step, newStep);
    }
  }

  void _animateNewStep(StepsGameDefaultItem newStep, int milliseconds) {
    newStep.arrow.animate(1);
    var delta = constants.floorWDef - constants.floorWMini;
    newStep.floor.updateSize(Offset(delta, 0), milliseconds: milliseconds);
    state.updatePositionSince(
        item: newStep.floor,
        offset: Offset(delta, 0),
        milliseconds: milliseconds);
  }
}
