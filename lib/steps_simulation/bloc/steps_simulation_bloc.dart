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
import 'package:matma/steps_simulation/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';

part 'steps_simulation_event.dart';
part 'steps_simulation_state.dart';

UniqueKey? hoverKepper;

class SimulationSize {
  final double hRatio;
  final double wRatio;

  double get hUnits => 1 / hRatio;
  double get wUnits => 1 / wRatio;

  const SimulationSize({required this.hRatio, required this.wRatio});
}

class StepsSimulationBloc
    extends Bloc<StepsSimulationEvent, StepsSimulationState> {
  final EquationBoardBloc board;
  final SimulationSize simSize;
  final List<UniqueKey> lockedIds = [];
  final TaskSimulationCubit taskCubit;
  bool isInsertionAnimation = false;

  @override
  StepsSimulationBloc(this.simSize, this.board, this.taskCubit)
      : super(StepsSimulationState(
            simSize: simSize, numbers: [], unorderedItems: {})) {
    state.numbers.addAll(initializeSimulationItems());
    //print("NUMBERS LEN: ${state.numbers.length}");
    // for (var number in state.numbers) {
    //   //print(number.number);
    // }

    on<StepsSimulationEventScroll>((event, emit) async {
      //print("BLOC: ${this.hashCode}");
      //print("NUMBERS LEN: ${state.numbers.length}");
      // for (var number in state.numbers) {
      //   //print(number.number);
      // }
      await handleScroll(state, event, simSize, emit);
    });

    on<StepsSimulationEventPointerDown>((event, emit) async {
      //print("BLOC: ${this.hashCode}");
      //print("NUMBERS LEN: ${state.numbers.length}");
      // for (var number in state.numbers) {
      //   //print(number.number);
      // }
      if (!isInsertionAnimation) {
        await handleClick(state, event, simSize, emit);
      }
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
        await handleClick(state, event, simSize, emit);
      }
    });
  }
}
