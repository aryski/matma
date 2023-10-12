import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/steps_simulation/steps_simulation.dart';
import 'package:matma/task_simulation/game_events/game_events.dart';
import 'package:matma/task_simulation/task.dart';

class Level1 extends StatelessWidget {
  const Level1({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      data: LevelData(
        name: 'Level1',
        gamesData: [
          StepsGameData(
              initNumbers: [1],
              shadedSteps: [3],
              firstTask: _taskA1,
              withEquationBoard: false),
          StepsGameData(
              initNumbers: [-1],
              shadedSteps: [-3],
              firstTask: _taskB1,
              withEquationBoard: false),
          StepsGameData(
              initNumbers: [1],
              shadedSteps: [3, -2, 4, -1],
              firstTask: _taskC1,
              withEquationBoard: false),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Hejka.', seconds: 3),
    NextMsg(text: 'Dojdź do obrazka w tle.', seconds: 7),
    NextMsg(text: 'Trzy zielone strzałki obok siebie.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [3]), task: _taskA2)
  ],
);

var _taskA2 = Task(instructions: [
  NextMsg(text: 'Udało Ci się!', seconds: 2),
  NextMsg(text: 'Spróbujmy czegoś innego.', seconds: 2),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Znowu dojdź do obrazka w tle.', seconds: 7),
    NextMsg(text: 'Trzy zielone strzałki obok siebie.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-3]), task: _taskB2)
  ],
);

var _taskB2 = Task(instructions: [
  NextMsg(text: 'Najs.', seconds: 2),
  NextMsg(text: 'Kolejny przykład.', seconds: 2),
  EndMsg(),
], onEvents: []);

var _taskC1 = Task(
  instructions: [
    NextMsg(text: 'Znowu dojdź do obrazka w tle.', seconds: 7),
    NextMsg(text: 'Uźyj złotych końcówek do dodania przeciwnych strzałek.')
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [3, -2, 4, -1]),
        task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'Gites majonez.', seconds: 2),
  EndMsg(),
], onEvents: []);
