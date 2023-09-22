import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/board_simulation/cubit/equation_board_cubit.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/click_handler.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/list_initializer.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

part 'steps_simulation_pro_event.dart';
part 'steps_simulation_pro_state.dart';

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

class StepsSimulationProBloc
    extends Bloc<StepsSimulationProEvent, StepsSimulationProState> {
  final BoardSimulationCubit board;
  final SimulationSize simSize;
  final List<UniqueKey> lockedIds = [];
  @override
  StepsSimulationProBloc(this.simSize, this.board)
      : super(StepsSimulationProState(simSize: simSize, items: [])) {
    state.items.addAll(initializeItemsList());
    on<StepsSimulationProEventScroll>((event, emit) async {
      await handleScroll(state, event, simSize, emit);
      board.update(currentNumbers());
    });

    on<StepsSimulationProEventPointerDown>((event, emit) async {
      print(lockedIds);
      print(event.id);
      if (!lockedIds.contains(event.id)) {
        print("ADD ${event.id}");
        lockedIds.add(event.id);
        await handleClick(state, event, simSize, emit);
      }
    });

    on<StepsSimulationProEventPointerUp>((event, emit) async {
      if (lockedIds.contains(event.id)) {
        if (event.pressTime.inMilliseconds >
            const Duration(milliseconds: 20).inMilliseconds) {
          await handleArrowInsertion(event, emit);
          board.update(currentNumbers());
        } else {
          await handleClick(state, event, simSize, emit);
        }
        print("REMOVE ${event.id}");
        await Future.delayed(Duration(milliseconds: 220));
        lockedIds.remove(event.id);
      }
    });
  }
}
