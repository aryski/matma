part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickHandler on StepsGameBloc {
  Future<void> handleClickArrow(
      StepsTrigEventClickArrow event, Emitter<StepsGameState> emit) async {
    if (event is StepsTrigEventClickUpArrow && isInsertionSafe(event)) {
      await handleArrowInsertion(event, emit, board, questsBloc);
    } else {
      await handleClickAnimation(state, event, emit, 200);
    }
  }

  bool isInsertionSafe(StepsTrigEventClickUpArrow event) {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      int? levelSince;
      var number = state.getNumberFromItem(item);
      if (number != null) {
        if (item.state.direction == Direction.up &&
            allowedOps.contains(StepsGameOps.addArrowUp)) {
          levelSince = state.maxiumumLevelSince(number);
        } else if (item.state.direction == Direction.down &&
            allowedOps.contains(StepsGameOps.addArrowDown)) {
          levelSince = state.minimumLevelSince(number);
        }
      }

      if (levelSince != null && levelSince.abs() < 7) {
        return true;
      }
    }
    return false;
  }

  Future<void> handleClickAnimation(
    StepsGameState state,
    dynamic event,
    Emitter<StepsGameState> emit,
    int milliseconds,
  ) async {
    if (event is StepsTrigEventClickDownArrow ||
        event is StepsTrigEventClickUpArrow) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = constants.arrowH - constants.arrowClickedHgt;
        if (event is StepsTrigEventClickDownArrow) {
          delta = -delta;
          onArrowClickDown(item, delta, milliseconds);
        } else {
          onArrowClickUp(item, delta, milliseconds);
        }
        updateStepHgt(item: item, delta: delta, milliseconds: milliseconds);
        await Future.delayed(Duration(milliseconds: milliseconds));
      }
    }
  }
}
