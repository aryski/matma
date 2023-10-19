import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class ArrowCubit extends GameItemCubit<ArrowState> {
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
        id: state.id,
        position: state.position,
        size: state.size,
        isHovered: state.isHovered,
        opacity: state.opacity,
        direction: state.direction,
        radius: state.radius,
        animProgress: i));
  }
}
