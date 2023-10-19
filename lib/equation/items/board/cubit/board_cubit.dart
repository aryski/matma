import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'board_state.dart';

class BoardCubit extends GameItemCubit<BoardState> {
  BoardCubit(super.initialState);

  void updateSize(Offset offset) {
    emit(BoardState(
      id: state.id,
      position: state.position,
      size: state.size + offset,
      opacity: state.opacity,
      radius: state.radius,
    ));
  }
}
