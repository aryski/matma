import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

extension NumberWithSignInsertor on EquationBloc {
  void insertNumberWithSignAfterItem(
      int value, EquationDefaultItem previousItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item == previousItem) {
        var numberState = BoardItemsGenerator.generateNumberState(
            number: value,
            position: Offset(previousItem.position.dx + simSize.wRatio * 1.5,
                previousItem.position.dy),
            opacity: 0,
            simSize: simSize);
        var numberCubit = NumberCubit(numberState);

        var signState = BoardItemsGenerator.generateSignState(
            sign: value > 0 ? Signs.addition : Signs.substraction,
            position:
                Offset(previousItem.position.dx, previousItem.position.dy),
            opacity: 0,
            simSize: simSize);
        var signCubit = SignCubit(signState);
        var myItem = EquationDefaultItem(sign: signCubit, number: numberCubit);
        state.items.insert(i + 1, myItem);
        numberCubit.updatePositionDelayed(
            Offset(previousItem.width, 0), const Duration(milliseconds: 20));
        signCubit.updatePositionDelayed(
            Offset(previousItem.width, 0), const Duration(milliseconds: 20));
        numberCubit.setOpacityDelayed(1, const Duration(milliseconds: 20));
        signCubit.setOpacityDelayed(1, const Duration(milliseconds: 20));
        spread(myItem, myItem.width);
        break;
      }
    }
  }

  void insertNumberWithoutSignAfterItem(
      int value, EquationDefaultItem previousItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item == previousItem) {
        var numberState = BoardItemsGenerator.generateNumberState(
            number: value,
            position:
                Offset(previousItem.position.dx, previousItem.position.dy),
            opacity: 0,
            simSize: simSize);
        var numberCubit = NumberCubit(numberState);

        var myItem = EquationDefaultItem(sign: null, number: numberCubit);
        state.items.insert(i + 1, myItem);
        numberCubit.updatePositionDelayed(
            Offset(previousItem.width, 0), const Duration(milliseconds: 20));

        numberCubit.setOpacityDelayed(1, const Duration(milliseconds: 20));

        spread(myItem, myItem.width);
        break;
      }
    }
  }
}
