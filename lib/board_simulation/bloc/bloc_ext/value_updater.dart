import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';

extension ValueUpdater on EquationBoardBloc {
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

      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.generateShadowNumberState(
              sign == Signs.addition ? "-1" : "+1",
              number.state.position,
              simSize));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePositionDelayed(
          Offset(0, simSize.hUnit * 2), const Duration(milliseconds: 20));
    }
  }
}
