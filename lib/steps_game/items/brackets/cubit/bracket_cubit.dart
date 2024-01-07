import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';
import 'package:matma/steps_game/items/brackets/cubit/bracket_state.dart';

class BracketCubit extends GameItemCubit<BracketState> {
  BracketCubit(super.initialState);

  Future<void> updateSize(Offset delta,
      {int delayInMillis = 0, int millis = 200}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }

    emit(state.copyWith(
        size: AnimatedProp(
            value: state.size.value + Offset(delta.dx, delta.dy),
            millis: millis)));
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
