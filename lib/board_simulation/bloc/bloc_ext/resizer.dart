import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension Resizer on EquationBoardBloc {
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
  }

  removeWithPositionUpdate(SimulationItemCubit item) {
    int? ind;
    for (int i = 0; i < state.items.length; i++) {
      if (state.items[i] == item) {
        ind = i;
      }
    }
    if (ind != null) {
      double delta = state.items[ind].state.size.dx;
      spread(ind, -delta);
      state.items.removeAt(ind);
    }
  }

  spread(int cubitsInd, double delta) {
    for (int j = 0; j <= cubitsInd; j++) {
      state.items[j].updatePosition(Offset(-delta / 2, 0));
    }

    for (int j = cubitsInd + 1; j < state.items.length; j++) {
      state.items[j].updatePosition(Offset(delta / 2, 0));
    }
  }
}