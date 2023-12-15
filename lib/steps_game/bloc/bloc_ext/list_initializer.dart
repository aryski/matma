part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension Initializer on StepsGameBloc {
  void initializeSimulationItems() {
    var equator = _generateEquator(constants.initialTop);
    state.unorderedItems[equator.state.id] = equator;
    var numbers = _generateNumbers(
        board.state.numbers, constants.initialLeft, constants.initialTop);

    // for (var number in numbers) {
    //   late double width;
    //   late double height;
    //   late Offset newPosition;
    //   late double heightOffset;

    //   const double bracketsY = -constants.arrowH * 3;

    //   if (number.number > 0) {
    //     var left = number.steps.first.arrow.state.position.value +
    //         const Offset(-constants.arrowW / 4, constants.arrowH);
    //     var right = number.steps.last.arrow.state.position.value +
    //         const Offset(constants.arrowW + constants.arrowW / 8, 0);
    //     height = (right.dy - left.dy).abs();
    //     width = (right.dx - left.dx).abs();

    //     newPosition = right + Offset(-width, 0);
    //     heightOffset = (bracketsY - newPosition.dy).abs() /
    //         (height + (bracketsY - newPosition.dy).abs());
    //     height = height + (bracketsY - newPosition.dy).abs();
    //     newPosition = Offset(newPosition.dx, bracketsY);
    //   } else {
    //     var left = number.steps.first.arrow.state.position.value +
    //         const Offset(constants.arrowW / 8, 0);
    //     var right = number.steps.last.arrow.state.position.value +
    //         const Offset(
    //             constants.arrowW / 4 + constants.arrowW, constants.arrowH);
    //     height = (right.dy - left.dy).abs();
    //     width = (right.dx - left.dx).abs();

    //     newPosition = left;
    //     heightOffset = (bracketsY - newPosition.dy).abs() /
    //         (height + (bracketsY - newPosition.dy).abs());
    //     height = height + (bracketsY - newPosition.dy).abs();
    //     newPosition = Offset(newPosition.dx, bracketsY);
    //   }

    //   // right += Offset(0, left.dy - right.dy);
    //   // if (number.number > 0) {
    //   //   left += Offset(0, constants.arrowH + 1.5 * constants.floorH);
    //   // } else
    //   //   left += Offset(0, -1.5 * constants.floorH - constants.arrowH * 2 / 4);

    //   var key = UniqueKey();
    //   var bracket = BracketCubit(BracketState(
    //       heightOffset: heightOffset,
    //       id: key,
    //       position: AnimatedProp.zero(
    //           value:
    //               newPosition), //+ Offset(0, -left.dy - constants.arrowH * 5)),
    //       size: AnimatedProp.zero(value: Offset(width, height)),
    //       direction: number.number > 0 ? Direction.up : Direction.down,
    //       opacity: AnimatedProp.zero(value: 1.0),
    //       radius: constants.radius));
    //   state.unorderedItems[key] = bracket;
    // }
    state.numbers.addAll(numbers);
    generateFillings();
  }

  EquatorCubit _generateEquator(double currentTop) {
    int wUnits = 66;
    var id = UniqueKey();
    return EquatorCubit(EquatorState(
        id: id,
        position:
            AnimatedProp.zero(value: Offset(0, currentTop + constants.arrowH)),
        size: AnimatedProp.zero(
            value: Offset(constants.arrowW * wUnits * 3, constants.floorH)),
        opacity: AnimatedProp.zero(value: 1),
        radius: constants.radius));
  }

  List<StepsGameNumberState> _generateNumbers(
      List<int> init, double currentLeft, double currentTop) {
    init.removeWhere((element) => element == 0);
    List<StepsGameNumberState> result = [];
    for (int j = 0; j < init.length; j++) {
      var firstLeft = currentLeft;
      int number = init[j];
      int stepsCount = number.abs();
      final List<StepsGameDefaultItem> steps = [];
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
            ? constants.floorWLarge - constants.arrowW / 4
            : constants.floorWDef - constants.arrowW / 4;
        var endLeft = currentLeft;
      }
      result.add(StepsGameNumberState(steps: steps));
    }
    return result;
  }

  StepsGameDefaultItem generateStep(Offset pos, bool isPos, double floorWidth) {
    ArrowCubit arrow = generateArrow(
        position:
            pos + Offset(0, isPos ? 0 : (constants.arrowH + constants.floorH)),
        direction: isPos ? Direction.up : Direction.down);
    FloorCubit floor = generateFloor(
      direction: isPos ? Direction.up : Direction.down,
      widthSize: floorWidth,
      position: pos +=
          Offset(constants.arrowW / 2, isPos ? 0 : 2 * constants.arrowH),
    );
    return StepsGameDefaultItem(arrow: arrow, floor: floor);
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

// bool isNextNumberSameSign(int j, List<int> init, int number) {
//   if (j + 1 < init.length) {
//     int nextNumber = init[j + 1];
//     if (nextNumber * number > 0) {
//       return true;
//     }
//   }
//   return false;
// }
