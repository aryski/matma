part of 'package:matma/equation/bloc/equation_bloc.dart';

enum FadeDirection { left, right }

extension Remover on EquationBloc {
  removeNumber(NumberItem myItem, FadeDirection fd, int millis) {
    for (var i = 0; i < state.items.length; i++) {
      NumberItem item = state.items[i];
      if (item == myItem) {
        double positionDelta = (fd == FadeDirection.left) ? -item.width : 0;
        myItem.value.updatePosition(Offset(positionDelta, 0), millis: millis);
        myItem.sign?.updatePosition(Offset(positionDelta, 0), millis: millis);
        myItem.value.setOpacity(0.0, millis: millis);
        myItem.value.refreshSwitcherKey();
        myItem.sign?.setOpacity(0.0, millis: millis);
        myItem.sign?.refreshSwitcherKey();
        spread(myItem, -myItem.width, millis);
        state.extraItems.add(item.value);
        if (item.sign != null) {
          state.extraItems.add(item.sign!);
        }
        state.items.remove(myItem);
        break;
      }
    }
  }
}
