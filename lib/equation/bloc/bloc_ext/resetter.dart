part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Resetter on EquationBloc {
  static EquationState hardResetState(
      List<int> updatedNumbers, GameSize gs, List<int>? targetValues) {
    var result1 = _generateBoardData(updatedNumbers, gs, false);
    var result2 = _generateBoardData(targetValues, gs, true);
    return EquationState(
        items: result1.$1,
        extraItems: result1.$2,
        fixedItems: result2.$1,
        fixedExtraItems: result2.$2);
  }

  static (List<EquationDefaultItem>, List<GameItemCubit>) _generateBoardData(
      List<int>? numbers, GameSize gs, bool withDarkenedColor) {
    if (numbers == null) {
      return ([], []);
    }
    var top = gs.hUnit / 2;
    var widthSpace = gs.wUnit * gs.wUnits;

    List<EquationDefaultItem> items = [];

    var result = _numbersToItemsStates(numbers, top, gs, withDarkenedColor);
    double totaldx = result.$1;
    List<GameItemState> states = result.$2;

    var allMargin = (widthSpace - totaldx) / 2;
    SignCubit? lastSignCubit;
    for (var state in states) {
      state = state.copyWith(
          position: AnimatedProp.zero(
              value: state.position.value + Offset(allMargin, 0)));
      if (state is SignState) {
        lastSignCubit = SignCubit(state);
      } else if (state is NumberState) {
        items.add(EquationDefaultItem(
            sign: lastSignCubit, number: NumberCubit(state)));
        lastSignCubit = null;
      }
    }
    var x = 0.02; //padding TODO
    var boardCubit = BoardCubit(BoardItemsGenerator.generateBoardState(
        position: Offset(allMargin - x / 2, top),
        size: Offset(totaldx + x, gs.hUnit * 2)));
    return (items, [boardCubit]);
  }

  static (double, List<GameItemState>) _numbersToItemsStates(
      List<int> updatedNumbers,
      double top,
      GameSize gs,
      bool withDarkenedColor) {
    List<GameItemState> states = [];
    double totaldx = 0;
    for (int i = 0; i < updatedNumbers.length; i++) {
      var number = updatedNumbers[i];
      SignState? signState;
      if (number > 0 && i != 0) {
        signState = BoardItemsGenerator.generateSignState(
            sign: Signs.addition, position: Offset(totaldx, top), gs: gs);
      } else if (number < 0) {
        signState = BoardItemsGenerator.generateSignState(
            sign: Signs.substraction, position: Offset(totaldx, top), gs: gs);
      }
      if (signState != null) {
        states.add(signState);
        totaldx += signState.size.value.dx;
      }

      var numberState = BoardItemsGenerator.generateNumberState(
          number: number,
          position: Offset(totaldx, top),
          gs: gs,
          withDarkenedColor: withDarkenedColor);
      states.add(numberState);
      totaldx += numberState.size.value.dx;
    }
    return (totaldx, states);
  }
}
