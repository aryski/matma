import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

class FloorCubit extends SimulationItemCubit<FloorState> {
  FloorCubit(super.initialState);

  Future<void> updateSizeDelayed(Duration delay, Offset delta) async {
    await Future.delayed(delay);
    updateSize(delta);
  }

  void updateSize(Offset delta) {
    state.size += Offset(delta.dx, delta.dy);
    emit(state.copy());
  }

  void updateColor(Color def, Color hov) {
    state.hovColor = hov;
    state.defColor = def;
    state.color = def;
    emit(state.copy());
  }
}
