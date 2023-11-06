import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class ArrowCubit extends GameItemCubit<ArrowState> {
  ArrowCubit(super.initialState);

  void updateHeight(double delta) {
    emit(state.copyWith(size: state.size + Offset(0, delta)));
  }

  void animate(double i) {
    emit(state.copyWith(animProgress: i));
  }
}
