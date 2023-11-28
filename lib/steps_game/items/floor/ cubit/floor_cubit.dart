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
    emit(state.copyWith(isLastInGame: true));
  }

  void setNotLastInGame() {
    emit(state.copyWith(isLastInGame: false));
  }
}
