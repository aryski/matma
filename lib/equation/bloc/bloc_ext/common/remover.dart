part of 'package:matma/equation/bloc/equation_bloc.dart';

enum FadeDirection { left, right }

extension Remover on EquationBloc {
  removeNumber(NumberItem myItem, FadeDirection fd) {
    for (var i = 0; i < state.items.length; i++) {
      NumberItem item = state.items[i];
      if (item == myItem) {
        NumberItem? previousItem = i - 1 >= 0 ? state.items[i - 1] : null;
        NumberItem? nextItem =
            i + 1 < state.items.length ? state.items[i + 1] : null;
        double positionDelta =
            (fd == FadeDirection.left) ? -item.width : item.width;
        if (previousItem != null && fd == FadeDirection.left) {
          positionDelta = -previousItem.width;
        } else if (nextItem != null && fd == FadeDirection.right) {
          positionDelta = nextItem.width;
        }
        myItem.value.updatePosition(Offset(positionDelta, 0));
        myItem.sign?.updatePosition(Offset(positionDelta, 0));
        myItem.value.setOpacity(0.0);
        myItem.value.refreshSwitcherKey();
        myItem.sign?.setOpacity(0.0);
        myItem.sign?.refreshSwitcherKey();
        spread(myItem, -myItem.width);
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
