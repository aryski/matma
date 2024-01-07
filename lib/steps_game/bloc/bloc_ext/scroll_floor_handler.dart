part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ScrollFloorHandler on StepsGameBloc {
  Future<void> handleScrollFloor(StepsGameState state,
      StepsTrigEventScrollFloor event, Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var delta = -event.dy;
    var rawDelta = delta;
    if (item is FloorCubit) {
      var width = item.state.size.value.dx;
      delta = guardDeltaSize(
          currentW: width,
          delta: delta,
          minW: areNeighboringArrowsOpposite(item, state)
              ? constants.floorWLarge
              : constants.floorWDef);
      if (!state.isLastItem(item)) {
        if (areNeighboringArrowsOpposite(item, state) &&
            rawDelta < 0 &&
            width <= constants.floorWLarge) {
          await handleReduction(item, rawDelta, state, emit);
        } else if (areNeighboringArrowsSame(item, state) &&
            delta < 0 &&
            width > constants.floorWDef &&
            width + delta <= constants.floorWDef) {
          handleJoin(item, delta, state, emit, 200);
        } else if (areNeighboringArrowsSame(item, state) &&
            delta > 0 &&
            width <= constants.floorWDef &&
            width + delta > constants.floorWDef) {
          handleSplit(item, delta, state, emit, 200);
        } else {
          resizeFloor(item, delta, state, emit, 200);
        }
      }
    }
  }
}

bool areNeighboringArrowsOpposite(FloorCubit? item, StepsGameState state) {
  return _compareNeighboringArrows(item, state, (p0, p1) => p0 != p1);
}

bool areNeighboringArrowsSame(FloorCubit? item, StepsGameState state) {
  return _compareNeighboringArrows(item, state, (p0, p1) => p0 == p1);
}

bool _compareNeighboringArrows(FloorCubit? item, StepsGameState state,
    bool Function(Direction, Direction) cmp) {
  if (item != null) {
    var step = state.getStep(item);
    if (step == null) return false;
    var rightStep = state.rightStep(step);
    if (rightStep == null) return false;
    var left = step.arrow;
    var right = rightStep.arrow;
    if (cmp(left.state.direction, right.state.direction)) {
      return true;
    }
  }
  return false;
}
