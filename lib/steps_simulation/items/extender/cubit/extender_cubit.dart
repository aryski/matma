import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:flutter/material.dart';
part 'extender_state.dart';

class ExtenderCubit extends SimulationItemCubit<ExtenderState> {
  ExtenderCubit(super.initialState);

  void updateSize(Offset delta) {
    state.size += Offset(delta.dx, delta.dy);
    emit(state.copy());
  }
}
