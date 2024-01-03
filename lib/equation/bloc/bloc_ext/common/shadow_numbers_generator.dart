part of 'package:matma/equation/bloc/equation_bloc.dart';

extension ShadowNumbersGenerator on EquationBloc {
  Future<void> generateShadowNumber(NumberItem item, String msg) async {
    if (state.items.contains(item)) {
      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.genShadowNumberState(
              msg, item.value.state.position.value));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePosition(Offset(0, constants.numberRatio.dy / 2),
          delayInMillis: 20, milliseconds: 1000);
    }
  }
}
