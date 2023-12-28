part of 'steps_game_bloc.dart';

@immutable
sealed class StepsTrigEvent {}

class StepsTrigEventScroll extends StepsTrigEvent {
  final UniqueKey id;
  final double dy;
  StepsTrigEventScroll(this.id, this.dy);
}

abstract class StepsTrigEventClick extends StepsTrigEvent {
  final UniqueKey id;
  final DateTime time;

  StepsTrigEventClick({required this.id, required this.time});
}

class StepsTrigEventClickUp extends StepsTrigEventClick {
  StepsTrigEventClickUp({required super.id, required super.time});
}

class StepsTrigEventClickDown extends StepsTrigEventClick {
  StepsTrigEventClickDown({required super.id, required super.time});
}

class StepsTrigEventPopFilling extends StepsTrigEvent {
  final UniqueKey id;
  StepsTrigEventPopFilling({required this.id});
}
