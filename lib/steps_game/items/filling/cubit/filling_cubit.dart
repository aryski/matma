import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'filling_state.dart';

class FillingCubit extends GameItemCubit<FillingState> {
  FillingCubit(super.initialState);

  void animateToLeft() {
    emit(state.copyWith(animProgress: -1));
  }

  void animateToRight() {
    emit(state.copyWith(animProgress: 1));
  }

  void animateToDef() {
    emit(state.copyWith(animProgress: 0));
  }

  void resizeWidth(double delta) {
    emit(state.copyWith(
        size: AnimatedProp<Offset>(
            value: state.size.value + Offset(delta, 0),
            duration: state.size.duration)));
  }
}
