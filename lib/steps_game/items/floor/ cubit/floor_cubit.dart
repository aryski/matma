import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class FloorCubit extends GameItemCubit<FloorState> {
  FloorCubit(super.initialState);

  Future<void> updateSizeDelayed(
      Duration delay, Offset delta, int milliseconds) async {
    await Future.delayed(delay);
    updateSize(delta, milliseconds);
  }

  void setLastInNumber() {
    emit(state.copyWith(isLastInNumber: true));
  }

  void setNotLastInNumber() {
    emit(state.copyWith(isLastInNumber: false));
  }

  void setLastInGame() {
    emit(state.copyWith(isLastInGame: true));
  }

  void setNotLastInGame() {
    emit(state.copyWith(isLastInGame: false));
  }

  void updateSize(Offset delta, int milliseconds) {
    print("Size update1: $delta");
    emit(state.copyWith(
        size: AnimatedProp(
            value: state.size.value + Offset(delta.dx, delta.dy),
            duration: milliseconds)));
  }
}
