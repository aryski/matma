part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickFloorHandler on StepsGameBloc {
  Future<void> handleClickFloor(
      StepsTrigEventClickFloor event, Emitter<StepsGameState> emit) async {
    if (allowedOps.contains(StepsGameOps.addOppositeArrow)) {
      var item = state.getItem(event.id);
      if (item is FloorCubit) {
        if (state.isLastItem(item)) {
          await handleOppositeInsertion(state, item, emit);
        }
      }
    }
  }

  Future<void> handleOppositeInsertion(StepsGameState state, FloorCubit item,
      Emitter<StepsGameState> emit) async {
    int millis = 200;
    var step = state.getStep(item);
    if (step == null) return;
    var dir = step.arrow.state.direction;
    ArrowCubit arrow;
    FloorCubit floor;
    bool isUp = (dir == Direction.up);
    board.add(EquationEventInsertNumber(number: isUp ? -1 : 1));
    item.updateSize(
        const Offset(constants.floorWLarge - constants.floorWDef, 0),
        millis: millis);
    await Future.delayed(Duration(milliseconds: millis));

    arrow = _generateInsertedArrow(item, isUp);
    floor = _generateInsertedFloor(item, isUp);
    state.numbers.add(StepsGameNumberState(
        steps: [StepsGameStep(arrow: arrow, floor: floor)]));
    questsBloc.add(TrigEventInsertedOpposite());
    item.setLastInNumber();
    generateFillings(millis);
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 20));
    arrow.updatePosition(Offset(0, isUp ? 0 : -constants.arrowH),
        millis: millis);
    floor.updatePosition(Offset(0, isUp ? constants.arrowH : -constants.arrowH),
        millis: millis);

    arrow.animate(1.0);
    arrow.updateHeight(constants.arrowH, millis);
    floor.updateSize(const Offset(constants.floorWDef, 0),
        delayInMillis: millis, millis: millis);

    floor.setLastInGame();
    item.setNotLastInGame();
    await Future.delayed(Duration(milliseconds: millis));
    return;
  }

  ArrowCubit _generateInsertedArrow(FloorCubit item, bool isUp) {
    return generateArrow(
        animationProgress: 0,
        position: item.state.position.value +
            Offset(
                item.state.size.value.dx -
                    constants.arrowW +
                    constants.arrowEndToCore,
                isUp ? constants.floorH : 0),
        size: AnimatedProp.zero(value: const Offset(constants.arrowW, 0)),
        direction: isUp ? Direction.down : Direction.up);
  }

  FloorCubit _generateInsertedFloor(FloorCubit item, bool isUp) {
    return generateFloor(
        direction: isUp ? Direction.down : Direction.up,
        position: item.state.position.value +
            Offset(item.state.size.value.dx - constants.arrowEndToCore, 0),
        size: AnimatedProp.zero(value: const Offset(0, constants.floorH)));
  }
}
