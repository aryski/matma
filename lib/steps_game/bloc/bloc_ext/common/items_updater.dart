part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ItemsUpdater on StepsGameBloc {
  void updatePositionSince(
      {required GameItemCubit item,
      required Offset offset,
      required int millis}) {
    bool hasItemBeenReached = false;
    for (var number in state.numbers) {
      //TODO breaks on level 6
      // if (!fillingIncluded && hasItemBeenReached) {
      //   number.filling?.updatePosition(offset, millis: millis);
      // }
      for (var step in number.steps) {
        if (hasItemBeenReached) {
          step.arrow.updatePosition(offset, millis: millis);
          step.floor.updatePosition(offset, millis: millis);
        }

        if (step.arrow == item || step.floor == item) {
          if ((step.arrow == item)) {
            step.floor.updatePosition(offset, millis: millis);
          }
          hasItemBeenReached = true;
        }
      }
      if (hasItemBeenReached) {
        number.filling?.updatePosition(offset, millis: millis);
      }
      // if (fillingIncluded && hasItemBeenReached) {
      //   number.filling?.updatePosition(offset, millis: millis);
      // }
    }
  }

  void updateStepHgt(
      {required ArrowCubit item, required double delta, required int millis}) {
    item.updateHeight(delta, millis);
    if (item.state.direction == Direction.up) {
      delta = -delta;
      item.updatePosition(Offset(0, delta), millis: millis);
    }
    updatePositionSince(item: item, offset: Offset(0, delta), millis: millis);
  }
}
