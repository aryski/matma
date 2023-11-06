import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class GameItemCubit<T extends GameItemState> extends Cubit<T> {
  GameItemCubit(super.initialState);

  void updatePosition(Offset delta) {
    emit(state.copyWith(position: state.position + delta) as T);
  }

  void updatePositionDelayed(Offset delta, Duration delay) async {
    await Future.delayed(delay);
    emit(state.copyWith(position: state.position + delta) as T);
  }

  void setOpacity(double opacity) {
    emit(state.copyWith(opacity: opacity) as T);
  }

  Future<void> setOpacityDelayed(double opacity, Duration delay) async {
    await Future.delayed(delay);
    emit(state.copyWith(opacity: opacity) as T);
  }

  void hoverStart() {
    emit(state.copyWith(isHovered: true) as T);
  }

  void hoverEnd() {
    emit(state.copyWith(isHovered: false) as T);
  }
}
