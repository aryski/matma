import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/click_handler.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/list_initializer.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';

part 'steps_simulation_event.dart';
part 'steps_simulation_state.dart';

UniqueKey? hoverKepper;

class SimulationSize {
  final double hUnit;
  final double wUnit;
  final int hUnits;
  final int wUnits;

  SimulationSize(
      {required this.hUnit,
      required this.wUnit,
      required this.hUnits,
      required this.wUnits});
}

class StepsSimulationBloc
    extends Bloc<StepsSimulationEvent, StepsSimulationState> {
  final EquationBoardBloc board;
  final SimulationSize simSize;
  final List<UniqueKey> lockedIds = [];
  final TaskSimulationCubit taskCubit;

  @override
  StepsSimulationBloc(this.simSize, this.board, this.taskCubit)
      : super(StepsSimulationState(
            simSize: simSize, numbers: [], unorderedItems: {})) {
    state.numbers.addAll(initializeItemsList());

    on<StepsSimulationEventScroll>((event, emit) async {
      await handleScroll(state, event, simSize, emit);
      // board.add(EquationBoardEventUpdate(currentNumbers()));
    });

    on<StepsSimulationEventPointerDown>((event, emit) async {
      await handleClick(state, event, simSize, emit);
    });

    on<StepsSimulationEventPointerUp>((event, emit) async {
      bool handled = false;
      if (event.pressTime.inMilliseconds >
          const Duration(milliseconds: 80).inMilliseconds) {
        var item = state.getItem(event.id);
        if (item != null) {
          if (item is ArrowCubit) {
            int? elo;
            if (item.state.direction == Direction.up) {
              elo = state.maxiumumLevelSince(item);
            } else if (item.state.direction == Direction.down) {
              elo = state.minimumLevelSince(item);
            }
            if (elo != null) {
              if (elo < 7 && elo > -7) {
                await handleArrowInsertion(event, emit, board, taskCubit);
                handled = true;
              }
            }
          }
        }
      }
      if (!handled) {
        await handleClick(state, event, simSize, emit);
      }

      // board.add(EquationBoardEventUpdate(currentNumbers()));
      // print("removing from lockeditd ${event.id}");
    });
  }
}
