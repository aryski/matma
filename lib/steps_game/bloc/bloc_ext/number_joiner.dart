part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension NumberSplitJoiner on StepsGameBloc {
  void handleJoin(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit) {
    delta = guardDeltaSize(
        currentW: item.state.size.value.dx,
        delta: delta,
        minW: constants.floorW);
    if (delta != 0) promptCubit.scrolled();
    item.updateSize(Offset(delta, 0), delayInMillis: 20, milliseconds: 200);
    int? numberInd = state.getNumberIndexFromItem(item);
    if (numberInd != null && state.numbers[numberInd].steps.isNotEmpty) {
      if (item.state.size.value.dx + delta <= constants.floorW) {
        handleJoinCore(state, numberInd, item, delta);
      }
      state.updatePositionSince(
          item: item,
          offset: Offset(delta, 0),
          fillingIncluded: false,
          milliseconds: 200);
      generateFillings();
      emit(state.copy());
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
          board.add(
              EquationEventJoinNumbers(leftInd: numberInd, rightInd: nextInd));
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
