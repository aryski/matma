import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'board_state.dart';

class BoardCubit extends GameItemCubit<BoardState> {
  BoardCubit(super.initialState);

  void updateSize(Offset offset, int milliseconds) {
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
