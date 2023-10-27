import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrow_insertor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/arrows_reductor.dart';
import 'package:matma/steps_game/bloc/bloc_ext/number_split_joiner.dart';
import 'package:matma/steps_game/bloc/bloc_ext/opposite_arrow_insertor.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ScrollHandler on StepsGameBloc {
  Future<void> handleScroll(StepsGameState state, StepsGameEventScroll event,
      GameSize gs, Emitter<StepsGameState> emit) async {
    var item = state.getItem(event.id);
    var minWidth = gs.wUnit * 1.25;
    var defaultWidth = 1.25 * gs.wUnit;
    var delta = -event.dy * gs.wUnit / 50;
    bool result = false;
    if (allowedOps.contains(StepsGameOps.addOppositeArrow)) {
      result = await handleOppositeInsertion(state, item, gs, emit);
      if (result) return;
    }
    if (allowedOps.contains(StepsGameOps.reduceArrows)) {
      result = await handleReduction(item, delta, defaultWidth, state, emit);
      if (result) return;
    }
    if (allowedOps.contains(StepsGameOps.splitJoinArrows)) {
      result = handleSplitJoin(item, delta, minWidth, gs, state, emit);
    }
  }

  List<int> currentNumbers() {
    return state.numbers.map((e) => e.number).toList();
  }
}
