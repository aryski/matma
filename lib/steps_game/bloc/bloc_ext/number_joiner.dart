part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension NumberSplitJoiner on StepsGameBloc {
  void handleJoin(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit) {
    var width = item.state.size.value.dx;
    delta = guardDeltaSize(
        currentW: width, delta: delta, minW: constants.floorWDef);
    if (delta != 0) questsBloc.add(TrigEventScrolled());
    int? numberInd = state.getNumberIndexFromItem(item);
    if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
      if (width + delta <= constants.floorWDef) {
        handleJoinCore(state, numberInd, item, delta);
      }
      state.updatePositionSince(
          item: item,
          offset: Offset(delta, 0),
          fillingIncluded: false,
          milliseconds: 200);
      item.updateSize(Offset(delta, 0), delayInMillis: 0, milliseconds: 200);
      state.getNumberFromItem(item)?.filling?.resizeWidth(delta);
      generateFillings();
      emit(state.copy());
    } else {
      item.updateSize(Offset(delta, 0), delayInMillis: 0, milliseconds: 200);
    }
  }

  void handleJoinCore(
      StepsGameState state, int numberInd, FloorCubit item, double delta) {
    if (state.numbers[numberInd].steps.last.floor == item) {
      int nextInd = numberInd + 1;
      if (nextInd < state.numbers.length) {
        var number = state.numbers[numberInd];
        var nextNumber = state.numbers[nextInd];
        if (number.number * nextNumber.number > 0) {
          board.add(EquationEventJoinNumbers(lInd: numberInd, rInd: nextInd));
          item.setNotLastInNumber();
          number.steps.addAll(nextNumber.steps);
          nextNumber.filling?.updatePosition(Offset(delta, 0));
          removeFilling(state, nextInd);
          state.numbers.remove(nextNumber);
        }
      }
    }
  }
}
