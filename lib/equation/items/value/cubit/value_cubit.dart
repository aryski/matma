import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

part 'value_state.dart';

class ValueCubit extends GameItemCubit<ValueState> {
  ValueCubit(super.initialState);
  void updateWithDarkenedColor(bool withDarkenedColor) {
    emit(state.copyWith(
        textKey: UniqueKey(), withDarkenedColor: withDarkenedColor));
  }

  updateValue(int value) {
    assert(value >= 0);
    emit(state.copyWith(value: value, textKey: UniqueKey()));
  }

  void updateSize(Offset offset, int milliseconds) {
    var size =
        AnimatedProp(duration: milliseconds, value: state.size.value + offset);
    emit(state.copyWith(size: size));
  }
}
