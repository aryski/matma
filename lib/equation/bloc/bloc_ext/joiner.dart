part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Joiner on EquationBloc {
  void join(NumberItem lItem, NumberItem rItem, int milliseconds) {
    updateValueWithResize(lItem, rItem.value.state.value, milliseconds);
    removeNumber(rItem, FadeDirection.left, milliseconds);
  }
}
