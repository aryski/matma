part of 'steps_simulation_pro_bloc.dart';

@immutable
sealed class StepsSimulationProEvent {}

class StepsSimulationProEventScroll extends StepsSimulationProEvent {
  final UniqueKey id;
  final double dy;
  StepsSimulationProEventScroll(this.id, this.dy);
}

class StepsSimulationProEventPointerDown extends StepsSimulationProEvent {
  final UniqueKey id;

  StepsSimulationProEventPointerDown({
    required this.id,
  });
}

class StepsSimulationProEventPointerUp extends StepsSimulationProEvent {
  final UniqueKey id;
  final Duration pressTime;

  StepsSimulationProEventPointerUp({required this.id, required this.pressTime});
}
