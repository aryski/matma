import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class GameItemCubit<T extends GameItemState> extends Cubit<T> {
  GameItemCubit(super.initialState);

  Future<void> updatePosition(Offset delta,
      {int delayInMillis = 0, int milliseconds = 200}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }
    emit(state.copyWith(
        position: AnimatedProp(
            duration: milliseconds, value: state.position.value + delta)) as T);
  }

  Future<void> setOpacity(double opacity,
      {int delayInMillis = 0, int milliseconds = 200}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }
    emit(state.copyWith(
        opacity: AnimatedProp(duration: milliseconds, value: opacity)) as T);
  }

  void hoverStart() {
    emit(state.copyWith(isHovered: true) as T);
  }

  void hoverEnd() {
    emit(state.copyWith(isHovered: false) as T);
  }
}
