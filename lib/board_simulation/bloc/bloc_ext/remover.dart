import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/resizer.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension Remover on EquationBoardBloc {
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
      state.extraItems.add(item);
      item.updatePosition(Offset(-item.state.size.dx, 0));
      item.setOpacity(0);
      state.items.removeAt(ind);
    }
  }
}
