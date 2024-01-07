part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension JoinHandler on StepsGameBloc {
  void handleJoin(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit, int milliseconds) {
    print("JOIN");

    var numberInd = state.getNumberIndexFromItem(item);
    if (numberInd == null) return;
    var nextNumberInd = numberInd + 1;
    if (nextNumberInd >= state.numbers.length) return;
    var number = state.numbers[numberInd];
    var nextNumber = state.numbers[nextNumberInd];
    board.add(EquationEventJoinNumbers(lInd: numberInd, rInd: nextNumberInd));
    item.setNotLastInNumber();
    number.steps.addAll(nextNumber.steps);
    nextNumber.filling
        ?.updatePosition(Offset(delta, 0), milliseconds: milliseconds);
    removeFilling(state, nextNumberInd, milliseconds);
    state.numbers.remove(nextNumber);
    resizeFloor(item, delta, state, emit, milliseconds);
    generateFillings(milliseconds);
    emit(state.copy());
  }
}
