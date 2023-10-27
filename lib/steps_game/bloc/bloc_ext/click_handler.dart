import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

extension ClickHandler on StepsGameBloc {
  Future<void> handleClick(
    StepsGameState state,
    dynamic event,
    GameSize gs,
    Emitter<StepsGameState> emit,
  ) async {
    if (event is StepsGameEventPointerDown ||
        event is StepsGameEventPointerUp) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = gs.arrowH - gs.arrowClickedHgt;
        if (event is StepsGameEventPointerDown) {
          delta = -delta;
        }
        if (item.state.direction == Direction.down) {
          state.moveAllSince(item, Offset(0, delta));
        } else {
          state.moveAllSinceIncluded(item, Offset(0, -delta));
        }
        item.updateHeight(delta);

        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }
}
