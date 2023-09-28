class OnEvent {
  final GameEvents requiredEvent;
  final Task task;

  OnEvent({required this.requiredEvent, required this.task});
}

class Instruction {
  final String text;
  final Duration? time;

  Instruction({required this.text, this.time});
}

class Task {
  final List<Instruction> instructions;
  final List<OnEvent> onEvents;

  OnEvent? isDone(List<GameEvents> recentEvents) {
    for (var onEvent in onEvents) {
      if (recentEvents.contains(onEvent.requiredEvent)) {
        return onEvent;
      }
    }
    return null;
  }

  Task({required this.instructions, required this.onEvents});
}

enum GameEvents {
  insertedUp,
  insertedDown,
  merged,
  splited,
  scrolled,
}
