part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Insertor on EquationBloc {
  void insertNumberAfterItem(int value, NumberItem previousItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item == previousItem) {
        var numberState = BoardItemsGenerator.genValueState(
            opacity: 0.99, //TODO HAX
            number: value,
            position: Offset(previousItem.position.dx + constants.signRatio.dx,
                previousItem.position.dy));
        var numberCubit = ValueCubit(numberState);
        var signState = BoardItemsGenerator.genSignState(
            sign: value > 0 ? Signs.addition : Signs.substraction,
            position:
                Offset(previousItem.position.dx, previousItem.position.dy),
            opacity: 0.99); //TODO FIXME
        var signCubit = SignCubit(signState);
        var myItem = NumberItem(sign: signCubit, value: numberCubit);
        state.items.insert(i + 1, myItem);
        numberCubit.updatePosition(Offset(previousItem.width, 0),
            delayInMillis: constants.smallDelayInMillis);
        signCubit.updatePosition(Offset(previousItem.width, 0),
            delayInMillis: constants.smallDelayInMillis);
        numberCubit.setOpacity(1, delayInMillis: constants.smallDelayInMillis);
        signCubit.setOpacity(1, delayInMillis: constants.smallDelayInMillis);
        spread(myItem, myItem.width);
        break;
      }
    }
  }
}
