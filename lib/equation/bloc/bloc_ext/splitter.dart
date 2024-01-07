part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Splitter on EquationBloc {
  Future<void> split(
      NumberItem item, EquationEventSplitNumber event, int milliseconds) async {
    updateValueWithResize(
        item, event.lNumber.abs() - item.value.state.value, milliseconds);
    insertNumberAfterItem(event.rNumber, item, milliseconds);
  }
}
