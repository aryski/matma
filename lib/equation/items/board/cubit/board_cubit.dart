import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'board_state.dart';

class BoardCubit extends GameItemCubit<BoardState> {
  BoardCubit(super.initialState);

  void updateSize(Offset offset, int milliseconds,
      {int delayInMillis = 0}) async {
    if (delayInMillis > 0) {
      await Future.delayed(Duration(milliseconds: delayInMillis));
    }

    emit(BoardState(
      id: state.id,
      position: state.position,
      size: AnimatedProp(
          duration: milliseconds, value: state.size.value + offset),
      opacity: state.opacity,
      radius: state.radius,
    ));
  }
}
