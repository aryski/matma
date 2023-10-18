import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'number_state.dart';

class NumberCubit extends GameItemCubit<NumberState> {
  NumberCubit(super.initialState);

  updateValue(int value) {
    assert(value >= 0);
    emit(NumberState(
        value: value,
        defColor: state.defColor,
        hovColor: state.hovColor,
        id: state.id,
        position: state.position,
        size: state.size,
        color: state.color,
        opacity: state.opacity,
        radius: state.radius,
        textKey: UniqueKey()));
  }

  void updateSize(Offset offset) {
    emit(NumberState(
        value: state.value,
        defColor: state.defColor,
        hovColor: state.hovColor,
        id: state.id,
        position: state.position,
        size: state.size + offset,
        color: state.color,
        opacity: state.opacity,
        radius: state.radius,
        textKey: state.textKey));
  }
}
