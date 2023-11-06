import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';

extension ClickHandler on StepsGameBloc {
  Future<void> handleClick(
      StepsGameEventClick event, Emitter<StepsGameState> emit) async {
    if (event is StepsGameEventClickUp && isSafe(event)) {
      await handleArrowInsertion(event, emit, board, taskCubit);
    } else {
      if (event is StepsGameEventClickUp) {
        downClick = event.time;
      }
      await handleClickAnimation(state, event, gs, emit);
    }
  }

  bool isSafe(StepsGameEventClickUp event) {
    Duration pressTime = event.time.difference(downClick);
    if (pressTime.inMilliseconds >
        const Duration(milliseconds: 80).inMilliseconds) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        int? levelSince;
        if (item.state.direction == Direction.up &&
            allowedOps.contains(StepsGameOps.addArrowUp)) {
          levelSince = state.maxiumumLevelSince(item);
        } else if (item.state.direction == Direction.down &&
            allowedOps.contains(StepsGameOps.addArrowDown)) {
          levelSince = state.minimumLevelSince(item);
        }
        if (levelSince != null && levelSince.abs() < 7) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> handleClickAnimation(
    StepsGameState state,
    dynamic event,
    GameSize gs,
    Emitter<StepsGameState> emit,
  ) async {
    if (event is StepsGameEventClickDown || event is StepsGameEventClickUp) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = gs.arrowH - gs.arrowClickedHgt;
        if (event is StepsGameEventClickDown) {
          delta = -delta;
        }
        state.updateStepHgt(item: item, delta: delta);
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }
}
