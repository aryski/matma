part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ClickFillingHandler on StepsGameBloc {
  Future<void> handleClickFilling(
      StepsTrigEventClickFilling event, Emitter<StepsGameState> emit) async {
    if (allowedOps.contains(StepsGameOps.reducingArrowsCascadedly)) {
      var item = state.getItem(event.id);
      if (item is FillingCubit) {
        var number = state.getNumberFromItem(item);
        if (number != null && number.steps.isNotEmpty) {
          var floor = number.steps.last.floor;
          await handleReduction(floor, -floor.state.size.value.dx, state, emit);
        }
      }
    }
  }
}
