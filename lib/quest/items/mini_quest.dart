import 'package:matma/quest/bloc/quests_bloc.dart';

class MiniQuest {
  final List<Prompt> prompts;
  final List<Choice> choices;

  Choice? returnTriggeredChoice(List<TrigEvent> recentTrigEvents) {
    for (var trigEvent in recentTrigEvents) {
      for (var choice in choices) {
        if (trigEvent.isEqual(choice.trigEvent)) {
          return choice;
        }
      }
    }
    return null;
  }

  MiniQuest({required this.prompts, required this.choices});
}

class Choice {
  final TrigEvent trigEvent;
  final MiniQuest miniQuest;

  Choice({required this.trigEvent, required this.miniQuest});
}

abstract class Prompt {}

class NextPrompt extends Prompt {
  final String text;
  final double seconds;

  NextPrompt({required this.text, this.seconds = 0});

  Duration get milliseconds => Duration(milliseconds: (seconds * 1000).toInt());
}

class EndPrompt extends Prompt {}
