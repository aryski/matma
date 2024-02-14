part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Joiner on EquationBloc {
  void join(NumberItem lItem, NumberItem rItem, int millis) {
    updateValueWithResize(lItem, rItem.value.state.value, millis);
    removeNumber(rItem, FadeDirection.left, millis);
  }
}
