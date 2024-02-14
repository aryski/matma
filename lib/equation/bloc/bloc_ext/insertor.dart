part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Insertor on EquationBloc {
  void insertNumberAfterItem(int value, NumberItem item, int millis) {
    for (int i = 0; i < state.items.length; i++) {
      if (state.items[i] == item) {
        var item = state.items[i];
        var numberState = BoardItemsGenerator.genValueState(
            number: value,
            position: Offset(
                item.position.dx + constants.signRatio.dx, item.position.dy));
        var numberCubit = ValueCubit(numberState);
        var signState = BoardItemsGenerator.genSignState(
          sign: value > 0 ? Signs.addition : Signs.substraction,
          position: Offset(item.position.dx, item.position.dy),
        );
        var signCubit = SignCubit(signState);
        var myItem = NumberItem(sign: signCubit, value: numberCubit);
        state.items.insert(i + 1, myItem);
        numberCubit.updatePosition(Offset(item.width, 0),
            delayInMillis: constants.smallDelayInMillis, millis: millis);
        signCubit.updatePosition(Offset(item.width, 0),
            delayInMillis: constants.smallDelayInMillis, millis: millis);
        numberCubit.refreshSwitcherKey();
        signCubit.refreshSwitcherKey();
        spread(myItem, myItem.width, millis);
        break;
      }
    }
  }
}
