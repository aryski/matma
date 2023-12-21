part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Remover on EquationBloc {
  removeNumber(NumberItem myItem) {
    for (var item in state.items) {
      if (item == myItem) {
        double delta = myItem.width;
        spread(myItem, -delta);
        state.extraItems.add(item.value);
        if (item.sign != null) {
          state.extraItems.add(item.sign!);
        }
        myItem.value
            .updatePosition(Offset(-myItem.value.state.size.value.dx, 0));
        myItem.sign
            ?.updatePosition(Offset(-myItem.value.state.size.value.dx, 0));
        myItem.value.setOpacity(0.0);
        myItem.sign?.setOpacity(0.0);
        state.items.remove(myItem);
        break;
      }
    }
  }
}
