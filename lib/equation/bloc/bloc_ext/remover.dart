part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Remover on EquationBloc {
  removeEquationDefaultItemWithPositionUpdate(EquationDefaultItem myItem) {
    for (var item in state.items) {
      if (item == myItem) {
        double delta = myItem.width;
        spread(myItem, -delta);
        state.extraItems.add(item.number);
        if (item.sign != null) {
          state.extraItems.add(item.sign!);
        }
        myItem.number
            .updatePosition(Offset(-myItem.number.state.size.value.dx, 0));
        myItem.sign
            ?.updatePosition(Offset(-myItem.number.state.size.value.dx, 0));
        myItem.number.setOpacity(constants.opacityNone);
        myItem.sign?.setOpacity(constants.opacityNone);
        state.items.remove(myItem);
      }
    }
  }
}
