part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Resetter on EquationBloc {
  static const y = 0.0;
  static const boardPadding = 14.0;
  static EquationState generateState(
      List<int> updatedNumbers, List<int>? targetValues) {
    var (items, extraItems) = _generateBoardData(updatedNumbers, false);
    var (fixedItems, fixedExtraItems) = _generateBoardData(targetValues, true);
    return EquationState(
      items: items,
      extraItems: extraItems,
      fixedItems: fixedItems,
      fixedExtraItems: fixedExtraItems,
    );
  }

  static (List<NumberItem>, List<GameItemCubit>) _generateBoardData(
      List<int>? numbers, bool withDarkenedColor) {
    if (numbers == null) {
      return ([], []);
    }

    var (totaldx, numberStates) = _numbersToStates(numbers, withDarkenedColor);
    var allMargin = (-totaldx) / 2;

    List<NumberItem> items = [];
    for (var (signState, valueState) in numberStates) {
      signState = signState?.copyWith(
        position: AnimatedProp.zero(
          value: signState.position.value + Offset(allMargin, y),
        ),
      );
      valueState = valueState.copyWith(
        position: AnimatedProp.zero(
          value: valueState.position.value + Offset(allMargin, y),
        ),
      );
      items.add(NumberItem(
          sign: signState != null ? SignCubit(signState) : null,
          value: ValueCubit(valueState)));
    }
    var boardCubit = BoardCubit(
      BoardItemsGenerator.genBoardState(
        position: Offset(allMargin - boardPadding, y),
        size: Offset(totaldx + 2 * boardPadding, constants.textHgt),
      ),
    );
    return (items, [boardCubit]);
  }

  static (double, List<(SignState?, ValueState)>) _numbersToStates(
      List<int> updatedNumbers, bool withDarkenedColor) {
    List<(SignState?, ValueState)> numberStates = [];
    double totaldx = 0;
    for (int i = 0; i < updatedNumbers.length; i++) {
      var number = updatedNumbers[i];
      SignState? signState;
      if (number < 0 || i != 0) {
        signState = BoardItemsGenerator.genSignState(
          sign: (number >= 0) ? Signs.addition : Signs.substraction,
          position: Offset(totaldx, y),
        );
        totaldx += signState.size.value.dx;
      }
      var valueState = BoardItemsGenerator.genValueState(
        number: number,
        position: Offset(totaldx, y),
        withDarkenedColor: withDarkenedColor,
      );
      numberStates.add((signState, valueState));
      totaldx += valueState.size.value.dx;
    }
    return (totaldx, numberStates);
  }
}
