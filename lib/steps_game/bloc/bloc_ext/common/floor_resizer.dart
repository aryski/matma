part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension FloorResizer on StepsGameBloc {
  void resizeFloor(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit, int millis) {
    updatePositionSince(
      item: item,
      offset: Offset(delta, 0),
      millis: millis,
    );
    state.getNumberFromItem(item)?.filling?.resizeWidth(
          delta: delta,
          millis: millis,
        );
    item.updateSize(Offset(delta, 0), delayInMillis: 0, millis: millis);
  }
}
