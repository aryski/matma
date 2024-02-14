import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'board_state.dart';

class BoardCubit extends GameItemCubit<BoardState> {
  BoardCubit(super.initialState);

  void updateSize(
      {required Offset offset, int millis = 200, int delayInMillis = 0}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }
    emit(state.copyWith(
        size: AnimatedProp(millis: millis, value: state.size.value + offset)));
  }
}
