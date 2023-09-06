import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_state.dart';

class SimulationItemCubit<T extends SimulationItemState> extends Cubit<T> {
  SimulationItemCubit(super.initialState);

  void updatePosition(Offset delta) {}

  void hoverStart() {
    state.color = state.hovColor;
    emit(state.copy() as T);
  }

  void hoverEnd() {
    state.color = state.defColor;
    emit(state.copy() as T);
  }
}
