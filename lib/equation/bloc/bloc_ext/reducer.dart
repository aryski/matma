part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Reducer on EquationBloc {
  void reduce(NumberItem leftItem, NumberItem rightItem, int milliseconds) {
    if (leftItem.value.state.value != 1 && rightItem.value.state.value != 1) {
      bool leftIsMinus = leftItem.sign != null &&
          leftItem.sign!.state.value == Signs.substraction;
      if (leftIsMinus) {
        generateShadowNumber(leftItem, constants.addMsg);
        generateShadowNumber(rightItem, constants.subMsg);
      } else {
        generateShadowNumber(leftItem, constants.subMsg);
        generateShadowNumber(rightItem, constants.addMsg);
      }
    }
    _decreaseValue(leftItem, milliseconds);
    _decreaseValue(rightItem, milliseconds);
    if (leftItem.value.state.value == 0 && rightItem.value.state.value == 0) {
      if (state.items.length <= 2) {
        if (leftItem.sign?.state.value == Signs.substraction) {
          removeNumber(leftItem, FadeDirection.right, milliseconds);
        } else {
          removeNumber(rightItem, FadeDirection.left, milliseconds);
        }
      } else {
        removeNumber(
            leftItem,
            leftItem.position.dx < 0 ? FadeDirection.right : FadeDirection.left,
            milliseconds);
        removeNumber(
            rightItem,
            rightItem.position.dx < 0
                ? FadeDirection.right
                : FadeDirection.left,
            milliseconds);
      }
    } else if (leftItem.value.state.value == 0) {
      removeNumber(leftItem, FadeDirection.right, milliseconds);
    } else if (rightItem.value.state.value == 0) {
      removeNumber(rightItem, FadeDirection.left, milliseconds);
    }

    bool doesFirstNumberHaveAdditionSign = state.items.isNotEmpty &&
        state.items.first.sign != null &&
        state.items.first.sign!.state.value == Signs.addition;

    if (doesFirstNumberHaveAdditionSign) {
      _removeAdditionSignFromFirstNumber(milliseconds);
    }
  }

  void _removeAdditionSignFromFirstNumber(int milliseconds) {
    state.extraItems.add(state.items.first.sign!);
    state.items.first.sign!.setOpacity(0, milliseconds: milliseconds);
    state.items.first.sign!.refreshSwitcherKey();
    state.items.replaceRange(
        0, 1, [NumberItem(sign: null, value: state.items.first.value)]);

    spread(state.items.first, -constants.signRatio.dx, milliseconds);
    state.items.first.value.updatePosition(Offset(-constants.signRatio.dx, 0),
        milliseconds: milliseconds);
  }

  void _decreaseValue(NumberItem myItem, int milliseconds) {
    updateValueWithResize(myItem, -1, milliseconds);
  }
}
