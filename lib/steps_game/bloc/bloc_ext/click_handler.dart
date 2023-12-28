part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickHandler on StepsGameBloc {
  Future<void> handleClick(
      StepsTrigEventClick event, Emitter<StepsGameState> emit) async {
    if (event is StepsTrigEventClickUp && isSafe(event)) {
      await handleArrowInsertion(event, emit, board, questsBloc);
    } else {
      if (event is StepsTrigEventClickUp) {
        downClick = event.time;
      }
      await handleClickAnimation(state, event, emit, 200);
    }
  }

  bool isSafe(StepsTrigEventClickUp event) {
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
    if (event is StepsTrigEventClickDown || event is StepsTrigEventClickUp) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = constants.arrowH - constants.arrowClickedHgt;
        if (event is StepsTrigEventClickDown) {
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
