import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/click_handler.dart';
import 'package:matma/steps_game/bloc/bloc_ext/list_initializer.dart';
import 'package:matma/steps_game/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_game/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/quests/cubit/quests_cubit.dart';

part 'steps_game_event.dart';
part 'steps_game_state.dart';

UniqueKey? hoverKepper;

class GameSize {
  final double hUnits;
  final double wUnits;

  double get hUnit => 1 / hUnits;
  double get wUnit => 1 / wUnits;

  double get arrowH => hUnit;
  double get arrowW => wUnit;

  double get radius => 1 / 15 * wUnit;

  double get floorH => arrowH / 5;

  // double get arrowH => hUnit;
  // double get arrowW => wUnit;

  const GameSize({required this.hUnits, required this.wUnits});
}

class StepsGameBloc extends Bloc<StepsGameEvent, StepsGameState> {
  final List<StepsGameOps> allowedOps;
  final EquationBloc board;
  final GameSize gs;
  final List<UniqueKey> lockedIds = [];
  final QuestsCubit taskCubit;
  bool isInsertionAnimation = false;

  @override
  StepsGameBloc(this.gs, this.board, this.taskCubit, this.allowedOps)
      : super(StepsGameState(gs: gs, numbers: [], unorderedItems: {})) {
    state.numbers.addAll(initializeSimulationItems());

    on<StepsGameEventScroll>((event, emit) async {
      await handleScroll(state, event, gs, emit);
    });

    on<StepsGameEventPointerDown>((event, emit) async {
      if (!isInsertionAnimation) {
        await handleClick(state, event, gs, emit);
      }
    });

    on<StepsGameEventPointerUp>((event, emit) async {
      bool handled = false;

      if (event.pressTime.inMilliseconds >
          const Duration(milliseconds: 80).inMilliseconds) {
        var item = state.getItem(event.id);
        if (item != null) {
          if (item is ArrowCubit) {
            int? elo;
            if (item.state.direction == Direction.up &&
                allowedOps.contains(StepsGameOps.addArrowUp)) {
              elo = state.maxiumumLevelSince(item);
            } else if (item.state.direction == Direction.down &&
                allowedOps.contains(StepsGameOps.addArrowDown)) {
              elo = state.minimumLevelSince(item);
            }
            if (elo != null) {
              if (elo < 7 && elo > -7) {
                //arrowInsertion
                isInsertionAnimation = true;
                await handleArrowInsertion(event, emit, board, taskCubit);
                isInsertionAnimation = false;
                handled = true;
              }
            }
          }
        }
      }
      if (!handled) {
        await handleClick(state, event, gs, emit);
      }
    });
  }
  @override
  void onChange(Change<StepsGameState> change) {
    taskCubit.equationValue(state.numbers.map((e) => e.number).toList());
    super.onChange(change);
  }
}
