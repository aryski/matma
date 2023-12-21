part of 'package:matma/equation/bloc/equation_bloc.dart';

extension Splitter on EquationBloc {
  void split(NumberItem item, EquationEventSplitNumber event) {
    item.value.updateValue(event.lNumber.abs());
    insertNumberAfterItem(event.rNumber, item);
  }
}
