part of 'equation_board_bloc.dart';

@immutable
sealed class EquationBoardEvent {}

// class EquationBoardEventUpdate extends EquationBoardEvent {
//   List<int> updatedNumbers;
//   EquationBoardEventUpdate(this.updatedNumbers);
// }

class EquationBoardEventMergeNumbers extends EquationBoardEvent {
  final int indLeft;
  final int indRight;

  EquationBoardEventMergeNumbers(
      {required this.indLeft, required this.indRight});
}

class EquationBoardEventIncreaseNumber extends EquationBoardEvent {
  final int ind;

  EquationBoardEventIncreaseNumber({required this.ind});
}

class EquationBoardEventSplitNumber extends EquationBoardEvent {
  final int ind;
  final int leftValue;
  final int rightValue;

  EquationBoardEventSplitNumber(
      {required this.ind, required this.leftValue, required this.rightValue});
}
