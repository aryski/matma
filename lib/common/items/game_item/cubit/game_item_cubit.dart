import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

class GameItemCubit<T extends GameItemState> extends Cubit<T> {
  GameItemCubit(super.initialState);

  void updatePosition(Offset delta, {int milliseconds = 200}) {
    emit(state.copyWith(
        position: AnimatedProp(
            duration: milliseconds, value: state.position.value + delta)) as T);
  }

  void updatePositionDelayed(Offset delta, Duration delay,
      {int milliseconds = 200}) async {
    await Future.delayed(delay);
    emit(state.copyWith(
        position: AnimatedProp(
            value: state.position.value + delta, duration: milliseconds)) as T);
  }

  void setOpacity(double opacity, {int milliseconds = 200}) {
    emit(state.copyWith(
        opacity: AnimatedProp(duration: milliseconds, value: opacity)) as T);
  }

  Future<void> setOpacityDelayed(double opacity, Duration delay,
      {int milliseconds = 200}) async {
    await Future.delayed(delay);
    emit(state.copyWith(
        opacity: AnimatedProp(duration: milliseconds, value: opacity)) as T);
  }

  void hoverStart() {
    print("hover started ${state.id}");

    emit(state.copyWith(isHovered: true) as T);
  }

  void hoverEnd() {
    print("hover ended  ${state.id}");
    emit(state.copyWith(isHovered: false) as T);
  }
}
