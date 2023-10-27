import 'package:flutter/material.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';

class FloorCubit extends GameItemCubit<FloorState> {
  FloorCubit(super.initialState);

  Future<void> updateSizeDelayed(Duration delay, Offset delta) async {
    await Future.delayed(delay);
    updateSize(delta);
  }

  void setLastInNumber() {
    state.isLastInNumber = true;
    emit(state.copy()); //todo add copy with
  }

  void setNotLastInNumber() {
    state.isLastInNumber = false;
    emit(state.copy());
  }

  void setLastInGame() {
    state.isLastInGame = true;
    emit(state.copy()); //todo add copy with
  }

  void setNotLastInGame() {
    state.isLastInGame = false;
    emit(state.copy()); //todo add copy with
  }

  void updateSize(Offset delta) {
    state.size += Offset(delta.dx, delta.dy);
    emit(state.copy());
  }
}
