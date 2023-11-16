import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

extension ShadowNumbersGenerator on EquationBloc {
  Future<void> generateShadowNumbers(
      EquationDefaultItem item, int delta) async {
    if (state.items.contains(item)) {
      var sign = Signs.substraction;
      if (item.sign != null) {
        if (item.sign!.state.value == Signs.substraction) {
          sign = Signs.addition;
        }
      }
      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.generateShadowNumberState(
              sign == Signs.addition ? "-1" : "+1",
              item.number.state.position.value,
              gs));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePositionDelayed(
          Offset(0, gs.hUnit * 2), const Duration(milliseconds: 20));
    }
  }
}
