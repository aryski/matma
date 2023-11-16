import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'shadow_number_state.dart';

class ShadowNumberCubit extends GameItemCubit<ShadowNumberState> {
  ShadowNumberCubit(super.initialState);
}
