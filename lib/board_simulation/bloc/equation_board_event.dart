part of 'equation_board_bloc.dart';

@immutable
sealed class EquationBoardEvent {}

class EquationBoardEventUpdate extends EquationBoardEvent {
  List<int> updatedNumbers;
  EquationBoardEventUpdate(this.updatedNumbers);
}
