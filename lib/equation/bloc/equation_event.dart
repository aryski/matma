part of 'equation_bloc.dart';

@immutable
sealed class EquationEvent {}

class EquationEventNumbersReduction extends EquationEvent {
  final int lInd;
  final int rInd;

  EquationEventNumbersReduction({required this.lInd, required this.rInd});
}

class EquationEventIncreaseNumber extends EquationEvent {
  final int ind;

  EquationEventIncreaseNumber({required this.ind});
}

class EquationEventInsertNumber extends EquationEvent {
  final int number;

  EquationEventInsertNumber({required this.number});
}

class EquationEventSplitNumber extends EquationEvent {
  final int ind;
  final int lNumber;
  final int rNumber;

  EquationEventSplitNumber(
      {required this.ind, required this.lNumber, required this.rNumber});
}

class EquationEventJoinNumbers extends EquationEvent {
  final int lInd;
  final int rInd;

  EquationEventJoinNumbers({required this.lInd, required this.rInd});
}
