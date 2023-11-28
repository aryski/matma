part of 'package:matma/equation/bloc/equation_bloc.dart';

extension ShadowNumbersGenerator on EquationBloc {
  Future<void> generateShadowNumbers(
      EquationDefaultItem item, int delta) async {
    if (state.items.contains(item)) {
      var sign = Signs.substraction;
      if (item.sign != null) {
        if (item.sign!.state.value == Signs.substraction) {
          sign = Signs.addition;
        }
      }
      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.generateShadowNumberState(
              sign == Signs.addition ? "-1" : "+1",
              item.number.state.position.value));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePosition(const Offset(0, 2), delayInMillis: 20);
    }
  }
}
