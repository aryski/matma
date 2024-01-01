part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Reducer on EquationBloc {
  void reduce(NumberItem leftItem, NumberItem rightItem) {
    if (leftItem.value.state.value != 1 && rightItem.value.state.value != 1) {
      generateShadowNumbers(leftItem, -1);
      generateShadowNumbers(rightItem, -1);
    }
    _decreaseValue(leftItem);
    _decreaseValue(rightItem);
    if (leftItem.value.state.value == 0) {
      removeNumber(leftItem, FadeDirection.right);
    }
    if (rightItem.value.state.value == 0) {
      removeNumber(rightItem, FadeDirection.left);
    }

    bool doesFirstNumberHaveAdditionSign = state.items.isNotEmpty &&
        state.items.first.sign != null &&
        state.items.first.sign!.state.value == Signs.addition;

    if (doesFirstNumberHaveAdditionSign) {
      _removeAdditionSignFromFirstNumber();
    }
  }

  void _removeAdditionSignFromFirstNumber() {
    state.extraItems.add(state.items.first.sign!);
    state.items.first.sign!.setOpacity(0);
    state.items.first.sign!.refreshSwitcherKey();
    state.items.replaceRange(
        0, 1, [NumberItem(sign: null, value: state.items.first.value)]);

    spread(state.items.first, -constants.signRatio.dx);
    state.items.first.value.updatePosition(Offset(-constants.signRatio.dx, 0));
  }

  void _decreaseValue(NumberItem myItem) {
    updateValueWithResize(myItem, -1);
  }
}
