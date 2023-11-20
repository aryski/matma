part of 'package:matma/equation/bloc/equation_bloc.dart';

extension NumberWithSignInsertor on EquationBloc {
  void insertNumberWithSignAfterItem(
      int value, EquationDefaultItem previousItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item == previousItem) {
        var numberState = BoardItemsGenerator.generateNumberState(
            number: value,
            position: Offset(
                previousItem.position.dx + gs.wUnit * constants.signRatio.dx,
                previousItem.position.dy),
            opacity: constants.opacityNone,
            gs: gs);
        var numberCubit = NumberCubit(numberState);

        var signState = BoardItemsGenerator.generateSignState(
            sign: value > 0 ? Signs.addition : Signs.substraction,
            position:
                Offset(previousItem.position.dx, previousItem.position.dy),
            opacity: constants.opacityNone,
            gs: gs);
        var signCubit = SignCubit(signState);
        var myItem = EquationDefaultItem(sign: signCubit, number: numberCubit);
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

  void insertNumberWithoutSignAfterItem(
      int value, EquationDefaultItem previousItem) {
    for (int i = 0; i < state.items.length; i++) {
      var item = state.items[i];
      if (item == previousItem) {
        var numberState = BoardItemsGenerator.generateNumberState(
            number: value,
            position:
                Offset(previousItem.position.dx, previousItem.position.dy),
            opacity: constants.opacityNone,
            gs: gs);
        var numberCubit = NumberCubit(numberState);
        var myItem = EquationDefaultItem(sign: null, number: numberCubit);

        state.items.insert(i + 1, myItem);
        numberCubit.updatePosition(Offset(previousItem.width, 0),
            delayInMillis: constants.smallDelayInMillis);
        numberCubit.setOpacity(constants.opacityFull,
            delayInMillis: constants.smallDelayInMillis);
        spread(myItem, myItem.width);
        break;
      }
    }
  }
}
