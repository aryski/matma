part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension SplitHandler on StepsGameBloc {
  void handleSplit(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit, int millis) {
    if (allowedOps.contains(StepsGameOps.splitJoinArrows)) {
      item.updateSize(Offset(delta, 0), millis: 200);
      var newW = item.state.size.value.dx;
      int? numberInd = state.getNumberIndexFromItem(item);
      if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
        if (newW > constants.floorWDef) {
          var myStep = state.getStep(item);
          if (myStep != null && state.numbers[numberInd].steps.last != myStep) {
            _splitNumber(numberInd: numberInd, splitStep: myStep);
            item.setLastInNumber();
            questsBloc.add(TrigEventSplited());
            var ind = state.getNumberIndexFromItem(item);
            if (ind != null) {
              animateNeigboringFillings(ind, false, millis);
            }
          }
          var id = state.getNumberIndexFromItem(item);
          if (id != null && state.numbers[id].steps.last.floor != item) {
            state.numbers[id].filling?.updatePosition(Offset(delta, 0),
                delayInMillis: 20, millis: millis);
          }
        }
        updatePositionSince(
            item: item, offset: Offset(delta, 0), millis: millis);
        generateFillings(millis);
        emit(state.copy());
      }
    }
  }

  void _splitNumber(
      {required int numberInd, required StepsGameStep splitStep}) {
    List<StepsGameStep> left = [];
    List<StepsGameStep> right = [];
    bool changed = false;
    var number = state.numbers[numberInd];
    for (var step in number.steps) {
      if (changed) {
        right.add(step);
      } else {
        left.add(step);
      }
      if (!changed && step == splitStep) {
        changed = true;
      }
    }
    state.numbers[numberInd].steps.clear();
    state.numbers[numberInd].steps.addAll(left);
    state.numbers.insert(numberInd + 1, StepsGameNumberState(steps: right));
    board.add(EquationEventSplitNumber(
        ind: numberInd,
        lNumber: state.numbers[numberInd].number,
        rNumber: state.numbers[numberInd + 1].number));
  }
}
