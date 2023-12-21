part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Joiner on EquationBloc {
  void join(NumberItem lItem, NumberItem rItem) {
    lItem.value.updateValue(lItem.value.state.value + rItem.value.state.value);
    removeNumber(rItem);
  }
}
