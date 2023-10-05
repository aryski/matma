part of 'equation_board_bloc.dart';

@immutable
sealed class EquationBoardEvent {}

class EquationBoardEventNumbersReduction extends EquationBoardEvent {
  final int indLeft;
  final int indRight;

  EquationBoardEventNumbersReduction(
      {required this.indLeft, required this.indRight});
}

class EquationBoardEventIncreaseNumber extends EquationBoardEvent {
  final int ind;

  EquationBoardEventIncreaseNumber({required this.ind});
}

class EquationBoardEventAddNumber extends EquationBoardEvent {
  final int value;

  EquationBoardEventAddNumber({required this.value});
}

class EquationBoardEventSplitNumber extends EquationBoardEvent {
  final int ind;
  final int leftValue;
  final int rightValue;

  EquationBoardEventSplitNumber(
      {required this.ind, required this.leftValue, required this.rightValue});
}

class EquationBoardEventJoinNumbers extends EquationBoardEvent {
  final int leftInd;
  final int rightInd;

  EquationBoardEventJoinNumbers(
      {required this.leftInd, required this.rightInd});
}
