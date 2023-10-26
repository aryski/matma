import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/remover.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/bloc_ext/shadow_numbers_generator.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

extension Reducer on EquationBloc {
  void reduce(EquationDefaultItem leftItem, EquationDefaultItem rightItem) {
    decreaseValue(leftItem);
    decreaseValue(rightItem);
    if (leftItem.number.state.value == 0) {
      removeEquationDefaultItemWithPositionUpdate(leftItem);
    }
    if (rightItem.number.state.value == 0) {
      removeEquationDefaultItemWithPositionUpdate(rightItem);
    }
    generateShadowNumbers(leftItem, -1);
    generateShadowNumbers(rightItem, -1);

    if (state.items.isNotEmpty &&
        state.items.first.sign != null &&
        state.items.first.sign!.state.value == Signs.addition) {
      state.extraItems.add(state.items.first.sign!);
      state.items.first.sign!.setOpacity(0);
      state.items.replaceRange(0, 1,
          [EquationDefaultItem(sign: null, number: state.items.first.number)]);

      spread(state.items.first, -1.5 * gs.wUnit);
      state.items.first.number.updatePosition(Offset(-1.5 * gs.wUnit, 0));
    }
  }
}
