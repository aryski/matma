import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/prompts/game_events/game_events.dart';
import 'package:matma/prompts/task.dart';

// Level 3
// Matching steps to equation.
class Level3 extends StatelessWidget {
  const Level3({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level4(),
      data: LevelData(
        name: 'Level3',
        gamesData: [
          StepsGameData(
            allowedOps: [StepsGameOps.addArrowUp],
            initNumbers: [1],
            withFixedEquation: [3],
            firstTask: _taskA1,
          ),
          StepsGameData(
            allowedOps: [StepsGameOps.addArrowDown],
            initNumbers: [-1],
            withFixedEquation: [-3],
            firstTask: _taskB1,
          ),
          StepsGameData(allowedOps: [
            StepsGameOps.addArrowDown,
            StepsGameOps.addArrowUp,
            StepsGameOps.addOppositeArrow
          ], initNumbers: [
            1
          ], withFixedEquation: [
            3,
            -2,
            4,
            -1
          ], firstTask: _taskC1),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Widzisz cyfrę?', seconds: 3),
    NextMsg(text: 'Zrób tyle strzałek.', seconds: 7),
    NextMsg(text: 'Trzy zielone strzałki.')
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
    NextMsg(text: 'Zrób -3 strzałki.', seconds: 7),
    NextMsg(text: 'Trzy czerwone strzałki.')
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
    NextMsg(text: 'Znowu, klikaj strzałki hop hop.'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [3, -2, 4, -1]),
        task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'No i elegancko.', seconds: 2),
  EndMsg(),
], onEvents: []);
