import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';

extension OppositeArrowInsertor on StepsGameBloc {
  Future<bool> handleOppositeInsertion(StepsGameState state, FloorCubit item,
      GameSize gs, Emitter<StepsGameState> emit) async {
    var step = state.getStep(item);
    if (step == null) return false;
    var dir = step.arrow.state.direction;
    ArrowCubit arrow;
    FloorCubit floor;
    bool isUp = (dir == Direction.up);
    board.add(EquationEventAddNumber(value: isUp ? -1 : 1));
    arrow = generateArrow(
        animationProgress: 0,
        position:
            item.state.position + Offset(gs.wUnit * 0.5, isUp ? gs.floorH : 0),
        size: Offset(gs.wUnit, 0),
        direction: isUp ? Direction.down : Direction.up);
    floor = generateFloor(
        direction: isUp ? Direction.down : Direction.up,
        position: item.state.position + Offset(gs.wUnit, 0),
        size: Offset(0, gs.floorH));
    state.numbers.add(StepsGameNumberState(
        [StepsGameDefaultItem(arrow: arrow, floor: floor)]));
    taskCubit.insertedOpposite();
    item.setLastInNumber();
    emit(state.copy());
    await Future.delayed(const Duration(milliseconds: 20));
    if (dir == Direction.up) {
      floor.updatePosition(Offset(0, gs.hUnit));
    } else {
      arrow.updatePosition(Offset(0, -gs.hUnit));
      floor.updatePosition(Offset(0, -gs.hUnit));
    }

    floor.updateSizeDelayed(
        const Duration(milliseconds: 200), Offset(1.25 * gs.wUnit, 0));
    arrow.animate(1.0);
    arrow.updateHeight(gs.hUnit);

    floor.setLastInGame();
    item.setNotLastInGame();
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
