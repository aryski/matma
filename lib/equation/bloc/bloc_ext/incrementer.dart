part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Incrementer on EquationBloc {
  void increment(NumberItem item) {
    generateShadowNumbers(item, 1);
    item.value.updateValue(item.value.state.value + 1);
    // TODO for now only double digits
    if (item.value.state.value == 10) {
      resize(item, constants.numberRatio.dx);
    }
  }
}
