import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'filling_state.dart';

class FillingCubit extends GameItemCubit<FillingState> {
  FillingCubit(super.initialState);

  void updateSize(Offset delta, int milliseconds) {
    print("Updating size2 $delta");
    var result = state.size.value + delta;
    if (result.dx < 0) {
      result = Offset.zero;
    }
    emit(state.copyWith(
        size: AnimatedProp(value: result, duration: milliseconds)));
  }

  void animateToLeft() {
    emit(state.copyWith(animProgress: -1));
  }

  void animateToRight() {
    emit(state.copyWith(animProgress: 1));
  }

  void animateToDef() {
    emit(state.copyWith(animProgress: 0));
  }
}
