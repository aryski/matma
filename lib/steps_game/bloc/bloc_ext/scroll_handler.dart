part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ScrollHandler on StepsGameBloc {
  Future<void> handleScroll(StepsGameState state, StepsGameEventScroll event,
      Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var delta = -event.dy * 1 / 2000;
    if (item is FloorCubit) {
      if (item.state.isLastInGame) {
        //OPPOSITE INSERTION
        if (allowedOps.contains(StepsGameOps.addOppositeArrow)) {
          await handleOppositeInsertion(state, item, emit);
        }
      } else if (item.state.isLastInNumber) {
        if (areNeighboringArrowsOpposite(item, state) && delta < 0) {
          if (item.state.size.value.dx <= constants.floorWLarge) {
            if (allowedOps.contains(StepsGameOps.reduceArrows)) {
              await handleReduction(item, delta, state, emit);
            }
          } else {
            if (true) {
              handleReductionWithoutReduction(item, delta, state, emit);
            }
          }
        } else {
          print("JOIN");
          handleJoin(item, delta, state, emit);
          //XDDD ok więc chyba działa, ale możnaby go w sumie troszkę zmodyfikować
          // delta = guardDeltaSize(
          //     currentW: item.state.size.value.dx, delta: delta, minW: constants.floorW);
          // item.updateSize(Offset(delta, 0));
          // updateFillingWidth(state, item, delta);
          // state.updatePositionSince(item, Offset(delta, 0));
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

double guardDeltaSize(
    {required double currentW, required double delta, required double minW}) {
  if (currentW + delta < minW) {
    delta = minW -
        currentW * 1.0000000000001; //TODO better floating point solution.
  }
  return delta;
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
