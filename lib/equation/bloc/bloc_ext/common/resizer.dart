part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Resizer on EquationBloc {
  resize(NumberItem myItem, double delta, {bool sizeUpdate = true}) {
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
        state.items[j].value.updatePosition(Offset(dx, 0));
        var sign = state.items[j].sign;
        if (sign != null) {
          sign.updatePosition(Offset(dx, 0));
        }
      }
      if (sizeUpdate) {
        state.items[itemsInd].value.updateSize(Offset(delta, 0), 200);
      }

      for (var item in state.extraItems) {
        if (item is BoardCubit) {
          item.updateSize(offset: Offset(delta, 0));
          item.updatePosition(Offset(-delta / 2, 0));
        }
      }
    }
  }

  spread(NumberItem myItem, double delta) {
    resize(myItem, delta, sizeUpdate: false);
  }
}
