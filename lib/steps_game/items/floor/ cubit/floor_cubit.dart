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

  void updateSize(Offset delta) {
    emit(state.copyWith(size: state.size + Offset(delta.dx, delta.dy)));
  }
}
