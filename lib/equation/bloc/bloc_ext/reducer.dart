part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Reducer on EquationBloc {
  void reduce(EquationDefaultItem leftItem, EquationDefaultItem rightItem) {
    print("REDUCE");
    decreaseValue(leftItem);
    decreaseValue(rightItem);
    if (leftItem.number.state.value == 0) {
      removeEquationDefaultItemWithPositionUpdate(leftItem);
    }
    if (rightItem.number.state.value == 0) {
      removeEquationDefaultItemWithPositionUpdate(rightItem);
    }
    generateShadowNumbers(leftItem, -1);
    generateShadowNumbers(rightItem, -1);

    if (state.items.isNotEmpty &&
        state.items.first.sign != null &&
        state.items.first.sign!.state.value == Signs.addition) {
      state.extraItems.add(state.items.first.sign!);
      state.items.first.sign!.setOpacity(0);
      state.items.replaceRange(0, 1,
          [EquationDefaultItem(sign: null, number: state.items.first.number)]);

      spread(state.items.first, -constants.signRatio.dx);
      state.items.first.number
          .updatePosition(Offset(-constants.signRatio.dx, 0));
    }
  }
}
