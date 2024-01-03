part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickHandler on StepsGameBloc {
  Future<void> handleClick(
      StepsTrigEventClickArrow event, Emitter<StepsGameState> emit) async {
    if (event is StepsTrigEventClickUpArrow && isInsertionSafe(event)) {
      await handleArrowInsertion(event, emit, board, questsBloc);
    } else {
      if (event is StepsTrigEventClickUpArrow) {
        downClick = event.time;
      }
      await handleClickAnimation(state, event, emit, 200);
    }
  }

  bool isInsertionSafe(StepsTrigEventClickUpArrow event) {
    Duration pressTime = event.time.difference(downClick);
    if (pressTime.inMilliseconds >
        const Duration(milliseconds: 80).inMilliseconds) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        int? levelSince;
        if (item.state.direction == Direction.up &&
            allowedOps.contains(StepsGameOps.addArrowUp)) {
          levelSince = state.maxiumumLevelSince(item);
        } else if (item.state.direction == Direction.down &&
            allowedOps.contains(StepsGameOps.addArrowDown)) {
          levelSince = state.minimumLevelSince(item);
        }
        if (levelSince != null && levelSince.abs() < 7) {
          return true;
        }
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
          onArrowClickDown(item, delta);
        } else {
          onArrowClickUp(item, delta);
        }
        state.updateStepHgt(
            item: item, delta: delta, milliseconds: milliseconds);
        await Future.delayed(Duration(milliseconds: milliseconds));
      }
    }
  }
}
