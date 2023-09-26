import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';

extension ClickHandler on StepsSimulationBloc {
  Future<void> handleClick(
    StepsSimulationState state,
    dynamic event,
    SimulationSize simSize,
    Emitter<StepsSimulationState> emit,
  ) async {
    if (event is StepsSimulationEventPointerDown ||
        event is StepsSimulationEventPointerUp) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = simSize.hUnit / 2;
        if (event is StepsSimulationEventPointerDown) {
          delta = -delta;
        }
        item.updateHeight(delta);
        if (item.state.direction == Direction.down) {
          state.moveAllSince(item, Offset(0, delta));
        } else {
          state.moveAllSinceIncluded(item, Offset(0, -delta));
        }
        await Future.delayed(Duration(milliseconds: 200));
      }
    }
  }
}
