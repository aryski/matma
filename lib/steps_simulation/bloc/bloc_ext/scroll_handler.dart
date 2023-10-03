import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/arrows_reductor.dart';
import 'package:matma/steps_simulation/bloc/bloc_ext/number_split_joiner.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

extension ScrollHandler on StepsSimulationBloc {
  Future<void> handleScroll(
      StepsSimulationState state,
      StepsSimulationEventScroll event,
      SimulationSize simSize,
      Emitter<StepsSimulationState> emit) async {
    var item = state.getItem(event.id);
    var minWidth = simSize.wUnit * 1.25;
    var defaultWidth = 1.25 * simSize.wUnit;
    var delta = -event.dy;
    bool result = await handleOppositeInsertion(state, item, simSize, emit);
    if (result) return;
    result = await handleReduction(item, delta, defaultWidth, state, emit);
    if (result) return;
    result = handleSplitJoin(item, delta, minWidth, simSize, state, emit);
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}
