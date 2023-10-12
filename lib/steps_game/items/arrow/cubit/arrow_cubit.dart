import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

class ArrowCubit extends SimulationItemCubit<ArrowState> {
  ArrowCubit(super.initialState);

  void slideIn() {}

  void gemmationClick() {}

  void gemmationClickEnd() {}

  void gemmationReset() {}

  void updateHeight(double delta) {
    state.size += Offset(0, delta);
    emit(state.copy());
  }

  void animate(double i) {
    emit(ArrowState(
        defColor: state.defColor,
        hovColor: state.hovColor,
        id: state.id,
        position: state.position,
        size: state.size,
        color: state.color,
        opacity: state.opacity,
        direction: state.direction,
        radius: state.radius,
        animProgress: i));
  }
}
