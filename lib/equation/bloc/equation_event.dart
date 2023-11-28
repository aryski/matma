part of 'equation_bloc.dart';

@immutable
sealed class EquationEvent {}

class EquationEventNumbersReduction extends EquationEvent {
  final int indLeft;
  final int indRight;

  EquationEventNumbersReduction(
      {required this.indLeft, required this.indRight});
}

class EquationEventIncreaseNumber extends EquationEvent {
  final int ind;

  EquationEventIncreaseNumber({required this.ind});
}

class EquationEventAddNumber extends EquationEvent {
  final int value;

  EquationEventAddNumber({required this.value});
}

class EquationEventSplitNumber extends EquationEvent {
  final int ind;
  final int leftValue;
  final int rightValue;

  EquationEventSplitNumber(
      {required this.ind, required this.leftValue, required this.rightValue});
}

class EquationEventJoinNumbers extends EquationEvent {
  final int leftInd;
  final int rightInd;

  EquationEventJoinNumbers({required this.leftInd, required this.rightInd});
}
