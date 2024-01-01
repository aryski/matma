part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Incrementer on EquationBloc {
  void increment(NumberItem item) {
    generateShadowNumbers(item, 1);
    updateValueWithResize(item, 1);
  }
}
