import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class GameItemCubit<T extends GameItemState> extends Cubit<T> {
  GameItemCubit(super.initialState);

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
    if (state.color == GameItemColor.def) {
      state.color = GameItemColor.hover;
    }
    emit(state.copy() as T);
  }

  void hoverEnd() {
    if (state.color == GameItemColor.hover) {
      state.color = GameItemColor.def;
    }
    emit(state.copy() as T);
  }
}
