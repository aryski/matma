part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Splitter on EquationBloc {
  Future<void> split(NumberItem item, EquationEventSplitNumber event) async {
    updateValueWithResize(item, event.lNumber.abs() - item.value.state.value);
    insertNumberAfterItem(event.rNumber, item);
  }
}
