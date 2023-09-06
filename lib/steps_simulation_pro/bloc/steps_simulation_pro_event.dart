part of 'steps_simulation_pro_bloc.dart';

@immutable
sealed class StepsSimulationProEvent {}

class StepsSimulationProEventScroll extends StepsSimulationProEvent {
  final UniqueKey id;
  final double dy;
  StepsSimulationProEventScroll(this.id, this.dy);
}
