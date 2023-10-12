import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

extension NumberWithSignInsertor on EquationBloc {
  void insertNumberWithSignAfterInd(int value, int itemInd) {
    if (itemInd < state.items.length) {
      var cubit = state.items[itemInd];
      var numberState = BoardItemsGenerator.generateNumberState(
          number: value,
          position: Offset(cubit.state.position.dx, cubit.state.position.dy),
          opacity: 0,
          simSize: simSize);

      var numberCubit = NumberCubit(numberState);
      _performInsertion(itemInd, numberCubit, cubit);

      var signState = BoardItemsGenerator.generateSignState(
          sign: value > 0 ? Signs.addition : Signs.substraction,
          position: Offset(cubit.state.position.dx, cubit.state.position.dy),
          opacity: 0,
          simSize: simSize);
      var signCubit = SignCubit(signState);
      _performInsertion(itemInd, signCubit, cubit);
    }
  }

  void _performInsertion(int itemInd, SimulationItemCubit insertedCubit,
      SimulationItemCubit<SimulationItemState> cubit) {
    state.items.insert(itemInd + 1, insertedCubit);
    insertedCubit.updatePositionDelayed(
        Offset(cubit.state.size.dx, 0), const Duration(milliseconds: 20));
    insertedCubit.setOpacityDelayed(1, const Duration(milliseconds: 20));
    spread(itemInd + 1, state.items[itemInd + 1].state.size.dx);
  }
}
