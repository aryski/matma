import 'package:flutter/material.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';

part 'board_state.dart';

class BoardCubit extends SimulationItemCubit<BoardState> {
  BoardCubit(super.initialState);

  void updateSize(Offset offset) {
    emit(BoardState(
      defColor: state.defColor,
      hovColor: state.hovColor,
      id: state.id,
      position: state.position,
      size: state.size + offset,
      color: state.color,
      opacity: state.opacity,
      radius: state.radius,
    ));
  }
}
