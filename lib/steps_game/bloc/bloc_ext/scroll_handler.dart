import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrows_reductor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/number_split_joiner.dart';
import 'package:matma/steps_game/bloc/bloc_ext/opposite_arrow_insertor.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension ScrollHandler on StepsGameBloc {
  Future<void> handleScroll(StepsGameState state, StepsGameEventScroll event,
      GameSize gs, Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var delta = -event.dy * gs.wUnit / 50;
    if (item is FloorCubit && state.isLastItem(item)) {
      if (allowedOps.contains(StepsGameOps.addOppositeArrow)) {
        await handleOppositeInsertion(state, item, gs, emit);
      }
    } else if (areNeighboringArrowsOpposite(item, state) &&
        (item is FloorCubit && item.state.opacity > 0) &&
        (item.state.size.dx <= gs.floorW && delta < 0)) {
      if (allowedOps.contains(StepsGameOps.reduceArrows)) {
        await handleReduction(item, delta, state, emit);
      }
    } else if ((item is FloorCubit && item.state.opacity > 0) &&
        (delta >= 0 || item.state.size.dx > gs.floorW)) {
      if (allowedOps.contains(StepsGameOps.splitJoinArrows)) {
        handleSplitJoin(item, delta, gs, state, emit);
      }
    } else if (item is FloorCubit) {
      delta = guardDeltaSize(
          currentW: item.state.size.dx, delta: delta, minW: gs.floorW);
      item.updateSize(Offset(delta, 0));
      state.updatePositionSince(item, Offset(delta, 0));
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}

double guardDeltaSize(
    {required double currentW, required double delta, required double minW}) {
  if (currentW + delta < minW) {
    delta = minW - currentW;
  }
  return delta;
}

bool areNeighboringArrowsOpposite(GameItemCubit? item, StepsGameState state) {
  if (item is FloorCubit) {
    var step = state.getStep(item);
    if (step == null) return false;
    var rightStep = state.rightStep(step);
    if (rightStep == null) return false;
    var left = step.arrow;
    var right = rightStep.arrow;
    if (left.state.direction != right.state.direction) {
      return true;
    }
  }
  return false;
}
