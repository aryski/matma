import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

class SimulationItemCubit<T extends SimulationItemState> extends Cubit<T> {
  SimulationItemCubit(super.initialState);

  void updatePosition(Offset delta) {
    state.position += delta;
    emit(state.copy() as T);
  }

  void updatePositionDelayed(Offset delta, Duration delay) async {
    await Future.delayed(delay);
    state.position += delta;
    emit(state.copy() as T);
  }

  void setOpacity(double opacity) {
    state.opacity = opacity;
    emit(state.copy() as T);
  }

  Future<void> setOpacityDelayed(double opacity, Duration delay) async {
    await Future.delayed(delay);
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
