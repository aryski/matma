import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

// Level 2
// Matching steps to shaded fixed steps, with above equation.
// TODO maybe better "in" animation of the equation.
class Level2 extends StatelessWidget {
  const Level2({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level3(),
      data: LevelData(
        name: 'Level2',
        gamesData: [
          StepsGameData(
              allowedOps: [StepsGameOps.addArrowUp],
              initNumbers: [1],
              shadedSteps: [3],
              firstTask: _taskA1,
              withEquation: true),
          StepsGameData(
              allowedOps: [StepsGameOps.addArrowDown],
              initNumbers: [-1],
              shadedSteps: [-3],
              firstTask: _taskB1,
              withEquation: true),
          StepsGameData(allowedOps: [
            StepsGameOps.addArrowDown,
            StepsGameOps.addArrowUp,
            StepsGameOps.addOppositeArrow
          ], initNumbers: [
            1
          ], shadedSteps: [
            3,
            -2,
            4,
            -1
          ], firstTask: _taskC1, withEquation: true),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Widzisz cyfrę?', seconds: 1.5),
    NextMsg(text: 'Obserwuj cyfrę!', seconds: 1.5),
    NextMsg(text: 'Zrób obrazek jak w tle.', seconds: 7),
    NextMsg(text: 'Trzy zielone obok siebie.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [3]), task: _taskA2)
  ],
);

var _taskA2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Znowu zrób obrazek jak w tle.', seconds: 7),
    NextMsg(text: 'Trzy zielone obok siebie.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-3]), task: _taskB2)
  ],
);

var _taskB2 = Task(instructions: [
  NextMsg(text: 'Najs.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskC1 = Task(
  instructions: [
    NextMsg(text: 'Znowu to samo, obserwuj górę'),
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
