part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension OppositeArrowInsertor on StepsGameBloc {
  Future<bool> handleOppositeInsertion(StepsGameState state, FloorCubit item,
      Emitter<StepsGameState> emit) async {
    var step = state.getStep(item);
    if (step == null) return false;
    var dir = step.arrow.state.direction;
    ArrowCubit arrow;
    FloorCubit floor;
    bool isUp = (dir == Direction.up);
    board.add(EquationEventAddNumber(value: isUp ? -1 : 1));
    arrow = generateArrow(
        animationProgress: 0,
        position: item.state.position.value +
            Offset(constants.arrowW * 0.5, isUp ? constants.floorH : 0),
        size: AnimatedProp.zero(value: const Offset(constants.arrowW, 0)),
        direction: isUp ? Direction.down : Direction.up);
    floor = generateFloor(
        direction: isUp ? Direction.down : Direction.up,
        position: item.state.position.value + const Offset(constants.arrowW, 0),
        size: AnimatedProp.zero(value: const Offset(0, constants.floorH)));
    state.numbers.add(StepsGameNumberState(
        steps: [StepsGameDefaultItem(arrow: arrow, floor: floor)]));
    taskCubit.insertedOpposite();
    item.setLastInNumber();
    // beforeEmit();
    // emit(state.copy());
    generateFillings();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 20));
    if (dir == Direction.up) {
      floor.updatePosition(const Offset(0, constants.arrowH));
    } else {
      arrow.updatePosition(const Offset(0, -constants.arrowH));
      floor.updatePosition(const Offset(0, -constants.arrowH));
    }

    floor.updateSize(const Offset(1.25 * constants.arrowW, 0),
        milliseconds: 200);
    arrow.animate(1.0);
    arrow.updateHeight(constants.arrowH, 200);

    floor.setLastInGame();
    item.setNotLastInGame();
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
