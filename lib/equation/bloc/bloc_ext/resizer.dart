part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Resizer on EquationBloc {
  resize(EquationDefaultItem myItem, double delta, {bool sizeUpdate = true}) {
    int? itemsInd;
    for (int i = 0; i < state.items.length; i++) {
      if (state.items[i] == myItem) {
        itemsInd = i;
        break;
      }
    }
    if (itemsInd != null) {
      for (int j = 0; j < state.items.length; j++) {
        var dx = j > itemsInd ? delta / 2 : -delta / 2;
        state.items[j].number.updatePosition(Offset(dx, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(dx, 0));
        }
      }
      if (sizeUpdate) {
        state.items[itemsInd].number.updateSize(Offset(delta, 0), 200);
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
    resize(myItem, delta, sizeUpdate: false);
  }
}
