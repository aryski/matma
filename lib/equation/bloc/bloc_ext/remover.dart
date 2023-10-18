import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension Remover on EquationBloc {
  removeEquationDefaultItemWithPositionUpdate(EquationDefaultItem myItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i]; //TODO
      if (item == myItem) {
        double delta = myItem.width;
        spread(myItem, -delta);
        state.extraItems.add(item.number);
        if (item.sign != null) {
          state.extraItems.add(item.sign!);
        }
        myItem.number.updatePosition(Offset(-myItem.number.state.size.dx, 0));
        myItem.sign?.updatePosition(Offset(-myItem.number.state.size.dx, 0));
        if (item.sign != null) {}
        myItem.number.setOpacity(0);
        myItem.sign?.setOpacity(0);
        state.items.remove(myItem);
      }
    }
  }
}
