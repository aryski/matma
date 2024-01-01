part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Updater on EquationBloc {
  void updateValueWithResize(NumberItem item, int delta) {
    var oldVal = item.value.state.value;
    var newVal = oldVal + delta;
    item.value.setValue(newVal);
    var lenDelta = newVal.toString().length - oldVal.toString().length;
    if (lenDelta != 0) {
      resize(item, constants.numberRatio.dx * lenDelta);
    }
  }
}
