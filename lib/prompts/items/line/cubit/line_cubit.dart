import 'package:flutter/material.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/common/items/game_item/cubit/game_item_state.dart';

part 'line_state.dart';

class LineCubit extends GameItemCubit<LineState> {
  LineCubit(super.initialState);
}
