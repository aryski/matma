import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/game_item.dart';

part 'sign_state.dart';

class SignCubit extends GameItemCubit<SignState> {
  SignCubit(super.initialState);
  void refreshSwitcherKey() async {
    await Future.delayed(Duration(milliseconds: 20));
    emit(state.copyWith(switcherKey: UniqueKey()));
  }
}
