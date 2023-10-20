import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/equation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension Resetter on EquationBloc {
  static EquationState hardResetState(List<int> updatedNumbers,
      SimulationSize simSize, List<int>? targetValues) {
    var result1 = _generateBoardData(updatedNumbers, simSize, false);
    var result2 = _generateBoardData(targetValues, simSize, true);
    return EquationState(
        items: result1.$1,
        extraItems: result1.$2,
        fixedItems: result2.$1,
        fixedExtraItems: result2.$2);
  }

  static (List<EquationDefaultItem>, List<GameItemCubit>) _generateBoardData(
      List<int>? numbers, SimulationSize simSize, bool withDarkenedColor) {
    if (numbers == null) {
      return ([], []);
    }
    var top = simSize.hRatio / 2;
    var widthSpace = simSize.wRatio * simSize.wUnits;

    List<EquationDefaultItem> items = [];

    var result =
        _numbersToItemsStates(numbers, top, simSize, withDarkenedColor);
    double totaldx = result.$1;
    List<GameItemState> states = result.$2;

    var allMargin = (widthSpace - totaldx) / 2 - simSize.wRatio / 6.7;
    SignCubit? lastSignCubit;
    for (var state in states) {
      state.position += Offset(allMargin, 0);
      if (state is SignState) {
        lastSignCubit = SignCubit(state);
      } else if (state is NumberState) {
        items.add(EquationDefaultItem(
            sign: lastSignCubit, number: NumberCubit(state)));
        lastSignCubit = null;
      }
    }
    var x = 0.02;
    var boardCubit = BoardCubit(BoardItemsGenerator.generateBoardState(
        position: Offset(allMargin - x / 2, top),
        size: Offset(totaldx + x, simSize.hRatio * 2)));
    return (items, [boardCubit]);
  }

  static (double, List<GameItemState>) _numbersToItemsStates(
      List<int> updatedNumbers,
      double top,
      SimulationSize simSize,
      bool withDarkenedColor) {
    List<GameItemState> states = [];
    double totaldx = 0;
    for (int i = 0; i < updatedNumbers.length; i++) {
      var number = updatedNumbers[i];
      SignState? signState;
      if (number > 0 && i != 0) {
        signState = BoardItemsGenerator.generateSignState(
            sign: Signs.addition,
            position: Offset(totaldx, top),
            simSize: simSize);
      } else if (number < 0) {
        signState = BoardItemsGenerator.generateSignState(
            sign: Signs.substraction,
            position: Offset(totaldx, top),
            simSize: simSize);
      }
      if (signState != null) {
        states.add(signState);
        totaldx += signState.size.dx;
      }

      var numberState = BoardItemsGenerator.generateNumberState(
          number: number,
          position: Offset(totaldx, top),
          simSize: simSize,
          withDarkenedColor: withDarkenedColor);
      states.add(numberState);
      totaldx += numberState.size.dx;
    }
    return (totaldx, states);
  }
}
