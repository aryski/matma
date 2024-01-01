part of 'package:matma/equation/bloc/equation_bloc.dart';

enum FadeDirection { left, right }

extension Remover on EquationBloc {
  removeNumber(NumberItem myItem, FadeDirection fd) async {
    for (var item in state.items) {
      if (item == myItem) {
        double positionDelta = (fd == FadeDirection.left)
            ? -myItem.value.state.size.value.dx
            : myItem.value.state.size.value.dx;
        myItem.value.updatePosition(Offset(positionDelta, 0));
        myItem.sign?.updatePosition(Offset(positionDelta, 0));
        myItem.value.setOpacity(0.0);
        myItem.value.refreshSwitcherKey();
        myItem.sign?.setOpacity(0.0);
        myItem.sign?.refreshSwitcherKey();
        await Future.delayed(const Duration(milliseconds: 200));
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
