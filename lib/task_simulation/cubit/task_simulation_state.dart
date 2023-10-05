abstract class TaskSimulationState {
  final String text;

  TaskSimulationState({required this.text});
}

class TaskSimulationStateDisplay extends TaskSimulationState {
  TaskSimulationStateDisplay({required super.text});
}

class TaskSimulationStateEndLevel extends TaskSimulationState {
  TaskSimulationStateEndLevel({required super.text});
}
