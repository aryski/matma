part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Joiner on EquationBloc {
  void join(NumberItem lItem, NumberItem rItem) {
    updateValueWithResize(lItem, rItem.value.state.value);
    removeNumber(rItem, FadeDirection.left);
  }
}
