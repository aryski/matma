import 'package:flutter/material.dart';
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

class FloorCubit extends SimulationItemCubit<FloorState> {
  FloorCubit(super.initialState);

  void updateSize(Offset delta) {
    state.size += Offset(delta.dx, delta.dy);
    emit(state.copy());
  }
}
