import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

class SimulationItemCubit<T extends SimulationItemState> extends Cubit<T> {
  SimulationItemCubit(super.initialState);

  void updatePosition(Offset delta) {
    print(
        "${state.position} ${state.position + delta} updating $this position");
    state.position += delta;
    emit(state.copy() as T);
  }

  void updatePositionDelayed(Offset delta, Duration delay) async {
    print(
        "${state.position} ${state.position + delta} updating start $this position");
    await Future.delayed(delay);
    state.position += delta;
    print(
        "${state.position} ${state.position + delta} updating end $this position");

    emit(state.copy() as T);
  }

  void setOpacity(double opacity) {
    state.opacity = opacity;
    emit(state.copy() as T);
  }

  void hoverStart() {
    state.color = state.hovColor;
    emit(state.copy() as T);
  }

  void hoverEnd() {
    state.color = state.defColor;
    emit(state.copy() as T);
  }
}
