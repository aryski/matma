part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Incrementer on EquationBloc {
  void increment(NumberItem item) {
    generateShadowNumber(item, constants.addMsg);
    updateValueWithResize(item, 1);
  }
}
