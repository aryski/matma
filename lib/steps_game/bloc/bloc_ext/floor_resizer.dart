part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension FloorResizer on StepsGameBloc {
  void resizeFloor(FloorCubit item, double delta, StepsGameState state,
      Emitter<StepsGameState> emit, int duration) {
    if (delta != 0) questsBloc.add(TrigEventScrolled());
    updatePositionSince(
      item: item,
      offset: Offset(delta, 0),
      fillingIncluded: false,
      milliseconds: duration,
    );
    state.getNumberFromItem(item)?.filling?.resizeWidth(
          delta: delta,
          duration: duration,
        );
    item.updateSize(Offset(delta, 0), delayInMillis: 0, milliseconds: duration);
  }
}
