import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

extension UpdateHandler on EquationBoardBloc {
  Future<void> updateValue(NumberCubit number, int delta) async {
    if (state.items.contains(number)) {
      var sign = state.getNumberSign(number);
      if (delta > 0) {
        if (sign == Signs.addition) {
          sign = Signs.substraction;
        } else if (sign == Signs.substraction) {
          sign = Signs.addition;
        }
      }

      var shadowCubit = ShadowNumberCubit(generateShadowNumberState(
          sign == Signs.addition ? "-1" : "+1",
          number.state.position,
          simSize));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePositionDelayed(
          Offset(0, simSize.hUnit * 2), const Duration(milliseconds: 20));
    }
  }

  static EquationBoardState hardResetState(
      List<int> updatedNumbers, SimulationSize simSize) {
    //animujemy nowe cyferki kompletnie
    var top = simSize.hUnit / 2;
    var widthSpace = simSize.wUnit * simSize.wUnits;
    //wiec od centrumr
    double length = 0;
    var signMargin = -0.0 * simSize.hUnit;
    var horizMargin = 0.0 * simSize.wUnit;
    List<SimulationItemCubit> cubits = [];
    List<SimulationItemState> states = [];
    for (int i = 0; i < updatedNumbers.length; i++) {
      var number = updatedNumbers[i];
      SignState? signState;
      if (number > 0 && i != 0) {
        signState = BoardItemsGenerator.generateSignState(
            Signs.addition, Offset(length, top), simSize);
      } else if (number < 0) {
        signState = BoardItemsGenerator.generateSignState(
            Signs.substraction, Offset(length, top), simSize);
      }
      if (signState != null) {
        states.add(signState);
        length += signState.size.dx;
      }

      var numberState = BoardItemsGenerator.generateNumberState(
          number, Offset(length, top), simSize);
      states.add(numberState);
      length += numberState.size.dx;
    }
    var allMargin = (widthSpace - length) / 2 - simSize.wUnit / 6.7;
    for (var state in states) {
      state.position += Offset(allMargin, 0);
      if (state is SignState) {
        cubits.add(SignCubit(state));
      } else if (state is NumberState) {
        cubits.add(NumberCubit(state));
      }
    }
    return EquationBoardState(items: cubits, extraItems: []);
  }
}
