import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'filling_state.dart';

class FillingCubit extends GameItemCubit<FillingState> {
  FillingCubit(super.initialState);

  void animateFoldLeft({required int millis}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.left, millis: millis)));
  }

  void animateFoldFull({required int millis}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.full, millis: millis)));
  }

  void animateFoldRight({required int millis}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.right, millis: millis)));
  }

  void animateFoldNone({required int millis}) {
    emit(state.copyWith(
        fold: AnimatedProp(value: FillingFold.none, millis: millis)));
  }

  void resizeWidth({required double delta, required int millis}) {
    emit(state.copyWith(
        size: AnimatedProp<Offset>(
            value: state.size.value + Offset(delta, 0), millis: millis)));
  }
}
