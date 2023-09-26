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
  @override
  StepsSimulationBloc(this.simSize, this.board)
      : super(StepsSimulationState(simSize: simSize, numbers: [])) {
    state.numbers.addAll(initializeItemsList());
    on<StepsSimulationEventScroll>((event, emit) async {
      await handleScroll(state, event, simSize, emit);
      // board.add(EquationBoardEventUpdate(currentNumbers()));
    });

    on<StepsSimulationEventPointerDown>((event, emit) async {
      //TODO better event queue
      print("XD2");
      if (!lockedIds.contains(event.id)) {
        lockedIds.add(event.id);
        await handleClick(state, event, simSize, emit);
      }
    });

    on<StepsSimulationEventPointerUp>((event, emit) async {
      print("XD3");
      if (lockedIds.contains(event.id)) {
        print("adding to lockeditd ${event.id}");
        if (event.pressTime.inMilliseconds >
            const Duration(milliseconds: 20).inMilliseconds) {
          await handleArrowInsertion(event, emit, board);
        } else {
          await handleClick(state, event, simSize, emit);
        }

        await Future.delayed(Duration(milliseconds: 220));
        print("XD2");
        // board.add(EquationBoardEventUpdate(currentNumbers()));
        print("removing from lockeditd ${event.id}");
        lockedIds.remove(event.id);
      }
    });
  }
}
