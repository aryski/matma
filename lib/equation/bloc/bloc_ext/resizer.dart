import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';

extension Resizer on EquationBloc {
  resize(int cubitsInd, double delta) {
    for (int j = 0; j <= cubitsInd; j++) {
      state.items[j].updatePosition(Offset(-delta / 2, 0));
    }
    if (state.items[cubitsInd] is NumberCubit) {
      (state.items[cubitsInd] as NumberCubit).updateSize(Offset(delta, 0));
    }
    for (int j = cubitsInd + 1; j < state.items.length; j++) {
      state.items[j].updatePosition(Offset(delta / 2, 0));
    }
    for (var item in state.extraItems) {
      if (item is BoardCubit) {
        item.updateSize(Offset(delta, 0));
        item.updatePosition(Offset(-delta / 2, 0));
      }
    }
  }

  spread(int cubitsInd, double delta) {
    for (int j = 0; j <= cubitsInd; j++) {
      state.items[j].updatePosition(Offset(-delta / 2, 0));
    }
    for (int j = cubitsInd + 1; j < state.items.length; j++) {
      state.items[j].updatePosition(Offset(delta / 2, 0));
    }
    for (var item in state.extraItems) {
      if (item is BoardCubit) {
        item.updateSize(Offset(delta, 0));
        item.updatePosition(Offset(-delta / 2, 0));
      }
    }
  }
}
