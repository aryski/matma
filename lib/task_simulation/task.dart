class OnEvent {
  final GameEvents requiredEvent;
  final Task task;

  OnEvent({required this.requiredEvent, required this.task});
}

abstract class Instruction {}

class ContinuingInstruction extends Instruction {
  final String text;
  final Duration? time;

  ContinuingInstruction({required this.text, this.time});
}

class EndInstruction extends Instruction {}

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
  insertedOpposite,
}
