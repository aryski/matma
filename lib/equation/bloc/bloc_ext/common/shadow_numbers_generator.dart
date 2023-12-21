part of 'package:matma/equation/bloc/equation_bloc.dart';

extension ShadowNumbersGenerator on EquationBloc {
  Future<void> generateShadowNumbers(NumberItem item, int delta) async {
    if (state.items.contains(item)) {
      var sign = Signs.substraction;
      if (item.sign != null) {
        if (item.sign!.state.value == Signs.substraction) {
          sign = Signs.addition;
        }
      }
      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.genShadowNumberState(
              sign == Signs.addition ? constants.addMsg : constants.subMsg,
              item.value.state.position.value));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePosition(Offset(0, constants.numberRatio.dy / 2),
          delayInMillis: 20, milliseconds: 1000);
    }
  }
}
