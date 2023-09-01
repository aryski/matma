part of 'stairs_simulation_bloc.dart';

@immutable
sealed class StepsSimulationEvent {}

class StepsSimulationScroll extends StepsSimulationEvent {
  final UniqueKey id;
  final double delta;

  StepsSimulationScroll(this.id, this.delta);
}

class StepsSimulationClick extends StepsSimulationEvent {
  final UniqueKey id;
  final DateTime time;

  StepsSimulationClick(this.id, this.time);
}

class StepsSimulationClickEnd extends StepsSimulationEvent {
  final UniqueKey id;
  final DateTime time;

  StepsSimulationClickEnd(this.id, this.time);
}

class StepsSimulationRetract extends StepsSimulationEvent {
  final UniqueKey id;
  final DateTime time;

  StepsSimulationRetract(this.id, this.time);
}

class StepsSimulationClickAnimationDone extends StepsSimulationEvent {
  final UniqueKey id;
  final DateTime time;

  StepsSimulationClickAnimationDone(this.id, this.time);
}

class StepsSimulationSubstract extends StepsSimulationEvent {}

class RegisterHover extends StepsSimulationEvent {
  final Hover? hover;

  RegisterHover({this.hover});
}
