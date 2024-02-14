part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickArrowHandler on StepsGameBloc {
  Future<void> handleClickArrow(StepsTrigEventClickArrow event,
      Emitter<StepsGameState> emit, int millis) async {
    if (event is StepsTrigEventClickUpArrow && _isInsertionSafe(event)) {
      await handleArrowInsertion(event, emit, board, questsBloc, millis);
    } else {
      await _handleClickArrowAnimation(state, event, emit, millis);
    }
  }

  bool _isInsertionSafe(StepsTrigEventClickUpArrow event) {
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
      return levelSince != null && levelSince.abs() < constants.maxSteps;
    }
    return false;
  }

  Future<void> _handleClickArrowAnimation(
    StepsGameState state,
    dynamic event,
    Emitter<StepsGameState> emit,
    int millis,
  ) async {
    if (event is StepsTrigEventClickDownArrow ||
        event is StepsTrigEventClickUpArrow) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = constants.arrowH - constants.arrowClickedHgt;
        if (event is StepsTrigEventClickDownArrow) {
          delta = -delta;
          onArrowClickDown(item, delta, millis);
        } else {
          onArrowClickUp(item, delta, millis);
        }
        updateStepHgt(item: item, delta: delta, millis: millis);
        await Future.delayed(Duration(milliseconds: millis));
      }
    }
  }
}
