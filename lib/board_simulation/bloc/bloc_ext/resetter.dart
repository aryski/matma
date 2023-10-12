import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/board/cubit/board_cubit.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension Resetter on EquationBoardBloc {
  static EquationBoardState hardResetState(
      List<int> updatedNumbers, SimulationSize simSize) {
    var top = simSize.hRatio / 2;
    var widthSpace = simSize.wRatio * simSize.wUnits;

    List<SimulationItemCubit> cubits = [];

    var result = _numbersToItemsStates(updatedNumbers, top, simSize);
    double totaldx = result.$1;
    List<SimulationItemState> states = result.$2;

    var allMargin = (widthSpace - totaldx) / 2 - simSize.wRatio / 6.7;

    for (var state in states) {
      state.position += Offset(allMargin, 0);
      if (state is SignState) {
        cubits.add(SignCubit(state));
      } else if (state is NumberState) {
        cubits.add(NumberCubit(state));
      }
    }
    var x = 0.02;
    var boardCubit = BoardCubit(BoardItemsGenerator.generateBoardState(
        position: Offset(allMargin - x / 2, top),
        size: Offset(totaldx + x, simSize.hRatio * 2)));

    return EquationBoardState(items: cubits, extraItems: [boardCubit]);
  }

  static (double, List<SimulationItemState>) _numbersToItemsStates(
      List<int> updatedNumbers, double top, SimulationSize simSize) {
    List<SimulationItemState> states = [];
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
          number: number, position: Offset(totaldx, top), simSize: simSize);
      states.add(numberState);
      totaldx += numberState.size.dx;
    }
    return (totaldx, states);
  }
}
