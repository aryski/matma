part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ScrollHandler on StepsGameBloc {
  Future<void> handleScroll(StepsGameState state, StepsTrigEventScroll event,
      Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var delta = -event.dy;
    if (item is FloorCubit) {
      if (item.state.isLastInGame) {
        //OPPOSITE INSERTION
        if (allowedOps.contains(StepsGameOps.addOppositeArrow)) {
          await handleOppositeInsertion(state, item, emit);
        }
      } else if (item.state.isLastInNumber) {
        if (areNeighboringArrowsOpposite(item, state) && delta < 0) {
          print("ELo");
          if (item.state.size.value.dx <= constants.floorWLarge) {
            if (allowedOps.contains(StepsGameOps.reduceArrows)) {
              await handleReduction(item, delta, state, emit);
            }
          } else {
            print("ELo2");
            handleReductionWithoutReduction(item, delta, state, emit);
          }
        } else {
          print("JOIN");
          handleJoin(item, delta, state, emit);
        }
      } else {
        if (allowedOps.contains(StepsGameOps.splitJoinArrows)) {
          print("SPLIT");
          handleSplit(item, delta, state, emit, 200);
        }
      }
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}

bool areNeighboringArrowsOpposite(GameItemCubit? item, StepsGameState state) {
  if (item is FloorCubit) {
    var step = state.getStep(item);
    if (step == null) return false;
    var rightStep = state.rightStep(step);
    if (rightStep == null) return false;
    var left = step.arrow;
    var right = rightStep.arrow;
    if (left.state.direction != right.state.direction) {
      return true;
    }
  }
  return false;
}
