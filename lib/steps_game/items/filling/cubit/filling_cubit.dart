import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'filling_state.dart';

class FillingCubit extends GameItemCubit<FillingState> {
  FillingCubit(super.initialState);

  void animateFoldLeft({required int duration}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.left, duration: duration)));
  }

  void animateFoldFull({required int duration}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.full, duration: duration)));
  }

  void animateFoldRight({required int duration}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.right, duration: duration)));
  }

  void animateFoldNone({required int duration}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.none, duration: duration)));
  }

  void resizeWidth({required double delta, required int duration}) {
    emit(state.copyWith(
        size: AnimatedProp<Offset>(
            value: state.size.value + Offset(delta, 0), duration: duration)));
  }
}
