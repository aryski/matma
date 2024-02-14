part of 'steps_game_bloc.dart';

@immutable
sealed class StepsTrigEvent {}

class StepsTrigEventScrollFloor extends StepsTrigEvent {
  final UniqueKey id;
  final double dy;
  StepsTrigEventScrollFloor(this.id, this.dy);
}

abstract class StepsTrigEventClickArrow extends StepsTrigEvent {
  final UniqueKey id;
  final DateTime time;

  StepsTrigEventClickArrow({required this.id, required this.time});
}

class StepsTrigEventClickUpArrow extends StepsTrigEventClickArrow {
  StepsTrigEventClickUpArrow({required super.id, required super.time});
}

class StepsTrigEventClickDownArrow extends StepsTrigEventClickArrow {
  StepsTrigEventClickDownArrow({required super.id, required super.time});
}

class StepsTrigEventClickFilling extends StepsTrigEvent {
  final UniqueKey id;
  StepsTrigEventClickFilling({required this.id});
}

class StepsTrigEventClickFloor extends StepsTrigEvent {
  final UniqueKey id;
  StepsTrigEventClickFloor({required this.id});
}
