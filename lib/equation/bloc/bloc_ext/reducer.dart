part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Reducer on EquationBloc {
  void reduce(NumberItem leftItem, NumberItem rightItem, int millis) {
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
    _decreaseValue(leftItem, millis);
    _decreaseValue(rightItem, millis);
    if (leftItem.value.state.value == 0 && rightItem.value.state.value == 0) {
      if (state.items.length <= 2) {
        if (leftItem.sign?.state.value == Signs.substraction) {
          removeNumber(leftItem, FadeDirection.right, millis);
        } else {
          removeNumber(rightItem, FadeDirection.left, millis);
        }
      } else {
        removeNumber(
            leftItem,
            leftItem.position.dx < 0 ? FadeDirection.right : FadeDirection.left,
            millis);
        removeNumber(
            rightItem,
            rightItem.position.dx < 0
                ? FadeDirection.right
                : FadeDirection.left,
            millis);
      }
    } else if (leftItem.value.state.value == 0) {
      removeNumber(leftItem, FadeDirection.right, millis);
    } else if (rightItem.value.state.value == 0) {
      removeNumber(rightItem, FadeDirection.left, millis);
    }

    bool doesFirstNumberHaveAdditionSign = state.items.isNotEmpty &&
        state.items.first.sign != null &&
        state.items.first.sign!.state.value == Signs.addition;

    if (doesFirstNumberHaveAdditionSign) {
      _removeAdditionSignFromFirstNumber(millis);
    }
  }

  void _removeAdditionSignFromFirstNumber(int millis) {
    state.extraItems.add(state.items.first.sign!);
    state.items.first.sign!.setOpacity(0, millis: millis);
    state.items.first.sign!.refreshSwitcherKey();
    state.items.replaceRange(
        0, 1, [NumberItem(sign: null, value: state.items.first.value)]);

    spread(state.items.first, -constants.signRatio.dx, millis);
    state.items.first.value
        .updatePosition(Offset(-constants.signRatio.dx, 0), millis: millis);
  }

  void _decreaseValue(NumberItem myItem, int millis) {
    updateValueWithResize(myItem, -1, millis);
  }
}
