part of 'steps_simulation_bloc.dart';

@immutable
sealed class StepsSimulationEvent {}

class StepsSimulationEventScroll extends StepsSimulationEvent {
  final UniqueKey id;
  final double dy;
  StepsSimulationEventScroll(this.id, this.dy);
}

class StepsSimulationEventPointerDown extends StepsSimulationEvent {
  final UniqueKey id;

  StepsSimulationEventPointerDown({
    required this.id,
  });
}

class StepsSimulationEventPointerUp extends StepsSimulationEvent {
  final UniqueKey id;
  final Duration pressTime;

  StepsSimulationEventPointerUp({required this.id, required this.pressTime});
}
