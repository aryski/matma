part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ItemsUpdater on StepsGameBloc {
  void updatePositionSince(
      {required GameItemCubit item,
      required Offset offset,
      bool fillingIncluded = true,
      required int millis}) {
    bool update = false;
    for (var number in state.numbers) {
      if (!fillingIncluded) {
        if (update && number.filling != null) {
          number.filling?.updatePosition(offset, millis: millis);
        }
      }
      for (var step in number.steps) {
        if (update) {
          step.arrow.updatePosition(offset, millis: millis);
          step.floor.updatePosition(offset, millis: millis);
        }

        if (step.arrow == item || step.floor == item) {
          if ((step.arrow == item)) {
            step.floor.updatePosition(offset, millis: millis);
          }
          update = true;
        }
      }
      if (fillingIncluded && update && number.filling != null) {
        number.filling?.updatePosition(offset, millis: millis);
      }
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
