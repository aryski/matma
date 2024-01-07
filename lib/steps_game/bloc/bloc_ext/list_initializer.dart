part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension Initializer on StepsGameBloc {
  void initializeSimulationItems() {
    var equator = _generateEquator(constants.initialTop);
    state.unorderedItems[equator.state.id] = equator;
    var numbers = _generateNumbers(
        board.state.numbers, constants.initialLeft, constants.initialTop);
    state.numbers.addAll(numbers);
    generateFillings(200);
  }

  EquatorCubit _generateEquator(double currentTop) {
    return EquatorCubit(
      EquatorState(
        id: UniqueKey(),
        position:
            AnimatedProp.zero(value: Offset(0, currentTop + constants.arrowH)),
        size: AnimatedProp.zero(
            value: const Offset(constants.equatorWidth, constants.floorH)),
        opacity: AnimatedProp.zero(value: 1.0),
      ),
    );
  }

  List<StepsGameNumberState> _generateNumbers(
      List<int> init, double currentLeft, double currentTop) {
    init.removeWhere((element) => element == 0);
    List<StepsGameNumberState> result = [];
    for (int j = 0; j < init.length; j++) {
      int number = init[j];
      int stepsCount = number.abs();
      final List<StepsGameStep> steps = [];
      for (int i = 0; i < stepsCount; i++) {
        var pos = Offset(currentLeft, currentTop);
        var isLastInNumber = i + 1 == stepsCount;
        var isLastInGame = j + 1 == init.length;
        var isPositive = number > 0;
        var step = generateStep(
            pos,
            isPositive,
            isLastInNumber && !isLastInGame
                ? constants.floorWLarge
                : constants.floorWDef);
        _updateLastness(
            isLastInNumber: i + 1 == stepsCount,
            isLastInGame: j + 1 == init.length,
            floor: step.floor);
        steps.add(step);

        currentTop += isPositive ? -constants.arrowH : constants.arrowH;
        currentLeft += isLastInNumber && !isLastInGame
            ? constants.floorWLarge - constants.arrowEndToCore
            : constants.floorWDef - constants.arrowEndToCore;
      }
      result.add(StepsGameNumberState(steps: steps));
    }
    return result;
  }

  StepsGameStep generateStep(Offset pos, bool isPositive, double floorWidth) {
    ArrowCubit arrow = generateArrow(
        position: pos +
            Offset(0, isPositive ? 0 : (constants.arrowH + constants.floorH)),
        direction: isPositive ? Direction.up : Direction.down);
    FloorCubit floor = generateFloor(
      direction: isPositive ? Direction.up : Direction.down,
      widthSize: floorWidth,
      position: pos +=
          Offset(constants.arrowW / 2, isPositive ? 0 : 2 * constants.arrowH),
    );
    return StepsGameStep(arrow: arrow, floor: floor);
  }
}

void _updateLastness(
    {required bool isLastInNumber,
    required bool isLastInGame,
    required FloorCubit floor}) {
  if (isLastInNumber) {
    if (isLastInGame) {
      floor.setLastInGame();
    }
    floor.setLastInNumber();
  }
}
