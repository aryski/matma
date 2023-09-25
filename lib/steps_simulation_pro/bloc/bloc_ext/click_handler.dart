import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';

extension ClickHandler on StepsSimulationProBloc {
  Future<void> handleClick(
    StepsSimulationProState state,
    dynamic event,
    SimulationSize simSize,
    Emitter<StepsSimulationProState> emit,
  ) async {
    if (event is StepsSimulationProEventPointerDown ||
        event is StepsSimulationProEventPointerUp) {
      var item = state.getItem(event.id);
      if (item is ArrowCubit) {
        var delta = simSize.hUnit / 2;
        if (event is StepsSimulationProEventPointerDown) {
          delta = -delta;
        }
        item.updateHeight(delta);
        if (item.state.direction == Direction.down) {
          state.moveAllSince(item, Offset(0, delta));
        } else {
          state.moveAllSinceIncluded(item, Offset(0, -delta));
        }
      }
    }
  }
}
