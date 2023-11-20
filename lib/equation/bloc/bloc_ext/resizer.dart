part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Resizer on EquationBloc {
  resize(EquationDefaultItem myItem, double delta) {
    int? itemsInd;
    for (int i = 0; i < state.items.length; i++) {
      if (state.items[i] == myItem) {
        itemsInd = i;
        break;
      }
    }
    if (itemsInd != null) {
      for (int j = 0; j <= itemsInd; j++) {
        state.items[j].number.updatePosition(Offset(-delta / 2, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(-delta / 2, 0));
        }
      }
      state.items[itemsInd].number.updateSize(Offset(delta, 0), 200);
      for (int j = itemsInd + 1; j < state.items.length; j++) {
        state.items[j].number.updatePosition(Offset(delta / 2, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(delta / 2, 0));
        }
      }
      for (var item in state.extraItems) {
        if (item is BoardCubit) {
          item.updateSize(Offset(delta, 0), 200);
          item.updatePosition(Offset(-delta / 2, 0));
        }
      }
    }
  }

  spread(EquationDefaultItem myItem, double delta) {
    int? itemsInd;
    for (int i = 0; i < state.items.length; i++) {
      if (state.items[i] == myItem) {
        itemsInd = i;
        break;
      }
    }
    if (itemsInd != null) {
      for (int j = 0; j <= itemsInd; j++) {
        state.items[j].number.updatePosition(Offset(-delta / 2, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(-delta / 2, 0));
        }
      }
      for (int j = itemsInd + 1; j < state.items.length; j++) {
        state.items[j].number.updatePosition(Offset(delta / 2, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(delta / 2, 0));
        }
      }
      for (var item in state.extraItems) {
        if (item is BoardCubit) {
          item.updateSize(Offset(delta, 0), 200);
          item.updatePosition(Offset(-delta / 2, 0));
        }
      }
    }
  }
}
