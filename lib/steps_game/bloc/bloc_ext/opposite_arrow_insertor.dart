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
    item.updateSize(
        Offset(constants.floorWLarge - constants.floorWDef, 0), //TODO
        milliseconds: 200);
    await Future.delayed(Duration(milliseconds: 200));
    arrow = generateArrow(
        animationProgress: 0,
        position: item.state.position.value +
            Offset(item.state.size.value.dx - constants.arrowW * 3 / 4,
                isUp ? constants.floorH : 0),
        size: AnimatedProp.zero(value: const Offset(constants.arrowW, 0)),
        direction: isUp ? Direction.down : Direction.up);
    floor = generateFloor(
        direction: isUp ? Direction.down : Direction.up,
        position: item.state.position.value +
            Offset(item.state.size.value.dx - 1 / 4 * constants.arrowW, 0),
        size: AnimatedProp.zero(value: const Offset(0, constants.floorH)));
    state.numbers.add(StepsGameNumberState(
        steps: [StepsGameDefaultItem(arrow: arrow, floor: floor)]));
    promptCubit.insertedOpposite();
    item.setLastInNumber();
    generateFillings();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 20));
    if (dir == Direction.up) {
      floor.updatePosition(const Offset(0, constants.arrowH));
    } else {
      arrow.updatePosition(const Offset(0, -constants.arrowH));
      floor.updatePosition(const Offset(0, -constants.arrowH));
    }

    arrow.animate(1.0);
    arrow.updateHeight(constants.arrowH, 200);
    floor.updateSize(const Offset(constants.floorWDef, 0),
        delayInMillis: 200, milliseconds: 200);

    floor.setLastInGame();
    item.setNotLastInGame();
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
