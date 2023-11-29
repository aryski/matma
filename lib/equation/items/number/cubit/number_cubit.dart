import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';

part 'number_state.dart';

class NumberCubit extends GameItemCubit<NumberState> {
  NumberCubit(super.initialState);
  void updateWithDarkenedColor(bool withDarkenedColor) {
    emit(
      NumberState(
        withDarkenedColor: withDarkenedColor,
        sign: state.sign,
        value: state.value,
        id: state.id,
        position: state.position,
        size: state.size,
        opacity: state.opacity,
        radius: state.radius,
        textKey: UniqueKey(),
      ),
    );
  }

  updateValue(int value) {
    assert(value >= 0);
    emit(
      NumberState(
        withDarkenedColor: state.withDarkenedColor,
        sign: state.sign,
        value: value,
        id: state.id,
        position: state.position,
        size: state.size,
        opacity: state.opacity,
        radius: state.radius,
        textKey: UniqueKey(),
      ),
    );
  }

  void updateSize(Offset offset, int milliseconds) {
    emit(
      NumberState(
        withDarkenedColor: state.withDarkenedColor,
        sign: state.sign,
        value: state.value,
        id: state.id,
        position: state.position,
        size: AnimatedProp(
            duration: milliseconds, value: state.size.value + offset),
        opacity: state.opacity,
        radius: state.radius,
        textKey: state.textKey,
      ),
    );
  }
}
