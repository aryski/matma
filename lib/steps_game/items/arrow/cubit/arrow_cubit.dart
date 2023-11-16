import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class ArrowCubit extends GameItemCubit<ArrowState> {
  ArrowCubit(super.initialState);

  void updateHeight(double delta, int milliseconds) {
    emit(state.copyWith(
        size: AnimatedProp(
            value: state.size.value + Offset(0, delta),
            duration: milliseconds)));
  }

  void animate(double i) {
    emit(state.copyWith(animProgress: i));
  }
}
