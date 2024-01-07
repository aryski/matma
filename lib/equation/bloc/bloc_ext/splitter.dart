part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Splitter on EquationBloc {
  Future<void> split(
      NumberItem item, EquationEventSplitNumber event, int millis) async {
    updateValueWithResize(
        item, event.lNumber.abs() - item.value.state.value, millis);
    insertNumberAfterItem(event.rNumber, item, millis);
  }
}
