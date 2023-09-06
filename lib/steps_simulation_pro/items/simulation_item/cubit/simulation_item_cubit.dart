import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_state.dart';

class SimulationItemCubit<T> extends Cubit<T> {
  SimulationItemCubit(super.initialState);

  void updatePosition(Offset delta) {
    if (state is SimulationItemState) {}
  }

  void hoverStart() {
    debugPrint("XD");
    (state as SimulationItemState).color =
        (state as SimulationItemState).hovColor;
    emit(state);
  }

  void hoverEnd() {
    (state as SimulationItemState).color =
        (state as SimulationItemState).defColor;
    emit(state);
  }
}
