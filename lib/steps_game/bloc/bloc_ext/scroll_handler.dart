import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrows_reductor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/number_split_joiner.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ScrollHandler on StepsGameBloc {
  Future<void> handleScroll(StepsGameState state, StepsGameEventScroll event,
      SimulationSize simSize, Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var minWidth = simSize.wRatio * 1.25;
    var defaultWidth = 1.25 * simSize.wRatio;
    var delta = -event.dy * simSize.wRatio / 50;
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
