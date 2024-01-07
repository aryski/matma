import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class FloorCubit extends GameItemCubit<FloorState> {
  FloorCubit(super.initialState);

  Future<void> updateSize(Offset delta,
      {int delayInMillis = 0, int milliseconds = 200}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }

    emit(state.copyWith(
        size: AnimatedProp(
            value: state.size.value + Offset(delta.dx, delta.dy),
            duration: milliseconds)));
  }

  void setLastInNumber() {
    emit(state.copyWith(isLastInNumber: true));
  }

  void setNotLastInNumber() {
    emit(state.copyWith(isLastInNumber: false));
  }

  void setLastInGame() {
    _setColors(FloorColors.special);
  }

  void setNotLastInGame() {
    _setColors(FloorColors.def);
  }

  void _setColors(FloorColors color) {
    emit(state.copyWith(
        colors: AnimatedProp(
            value: color, duration: color != state.colors.value ? 400 : 0)));
  }
}
