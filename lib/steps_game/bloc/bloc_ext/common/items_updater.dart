part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ItemsUpdater on StepsGameBloc {
  void updatePositionSince(
      {required GameItemCubit item,
      required Offset offset,
      bool fillingIncluded = true,
      required int milliseconds}) {
    bool update = false;
    for (var number in state.numbers) {
      if (!fillingIncluded) {
        if (update && number.filling != null) {
          number.filling?.updatePosition(offset, milliseconds: milliseconds);
        }
      }
      for (var step in number.steps) {
        if (update) {
          step.arrow.updatePosition(offset, milliseconds: milliseconds);
          step.floor.updatePosition(offset, milliseconds: milliseconds);
        }

        if (step.arrow == item || step.floor == item) {
          if ((step.arrow == item)) {
            step.floor.updatePosition(offset, milliseconds: milliseconds);
          }
          update = true;
        }
      }
      if (fillingIncluded && update && number.filling != null) {
        number.filling?.updatePosition(offset, milliseconds: milliseconds);
      }
    }
  }

  void updateStepHgt(
      {required ArrowCubit item,
      required double delta,
      required int milliseconds}) {
    item.updateHeight(delta, milliseconds);
    if (item.state.direction == Direction.up) {
      delta = -delta;
      item.updatePosition(Offset(0, delta), milliseconds: milliseconds);
    }
    updatePositionSince(
        item: item, offset: Offset(0, delta), milliseconds: milliseconds);
  }
}
