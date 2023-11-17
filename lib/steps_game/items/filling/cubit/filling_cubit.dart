import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'filling_state.dart';

class FillingCubit extends GameItemCubit<FillingState> {
  FillingCubit(super.initialState);

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
