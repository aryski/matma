part of 'steps_game_bloc.dart';

@immutable
sealed class StepsGameEvent {}

class StepsGameEventScroll extends StepsGameEvent {
  final UniqueKey id;
  final double dy;
  StepsGameEventScroll(this.id, this.dy);
}

abstract class StepsGameEventClick extends StepsGameEvent {
  final UniqueKey id;
  final DateTime time;

  StepsGameEventClick({required this.id, required this.time});
}

class StepsGameEventClickUp extends StepsGameEventClick {
  StepsGameEventClickUp({required super.id, required super.time});
}

class StepsGameEventClickDown extends StepsGameEventClick {
  StepsGameEventClickDown({required super.id, required super.time});
}

class StepsGameEventPopFilling extends StepsGameEvent {
  final UniqueKey id;
  StepsGameEventPopFilling({required this.id});
}
