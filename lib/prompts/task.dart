import 'package:matma/prompts/game_events/game_events.dart';

class OnEvent {
  final GameEvent requiredEvent;
  final Task task;

  OnEvent({required this.requiredEvent, required this.task});
}

abstract class Instruction {}

class NextMsg extends Instruction {
  final String text;
  final double seconds;

  NextMsg({required this.text, this.seconds = 0});

  Duration get milliseconds => Duration(milliseconds: (seconds * 1000).toInt());
}

class EndMsg extends Instruction {}

class Task {
  final List<Instruction> instructions;
  final List<OnEvent> onEvents;

  OnEvent? isDone(List<GameEvent> recentEvents) {
    for (var onEvent in onEvents) {
      for (var event in recentEvents) {
        if (event.isEqual(onEvent.requiredEvent)) {
          return onEvent;
        }
      }
    }
    return null;
  }

  Task({required this.instructions, required this.onEvents});
}
