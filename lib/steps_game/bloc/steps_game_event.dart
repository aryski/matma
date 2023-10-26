part of 'steps_game_bloc.dart';

@immutable
sealed class StepsGameEvent {}

class StepsGameEventScroll extends StepsGameEvent {
  final UniqueKey id;
  final double dy;
  StepsGameEventScroll(this.id, this.dy);
}

class StepsGameEventPointerDown extends StepsGameEvent {
  final UniqueKey id;

  StepsGameEventPointerDown({
    required this.id,
  });
}

class StepsGameEventPointerUp extends StepsGameEvent {
  final UniqueKey id;
  final Duration pressTime;

  StepsGameEventPointerUp({required this.id, required this.pressTime});
}

class StepsGameEventPop extends StepsGameEvent {}
