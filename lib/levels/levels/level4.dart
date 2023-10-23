import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

// Level 4
// Matching steps to equation.
//Zadanie 4
//Rozbijanie 2 na 1+1, rozbijanie -3 na -1,-1,-1, rozbijanie 3-3 na 1 + 1 + 1 - 1 - 1 -1
class Level4 extends StatelessWidget {
  const Level4({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level5(),
      data: LevelData(
        name: 'Level4',
        gamesData: [
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow
            ],
            initNumbers: [2],
            // withFixedEquation: [1, 1],
            firstTask: _taskA1,
          ),
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow
            ],
            initNumbers: [-3],
            // withFixedEquation: [-1, -1, -1],
            firstTask: _taskB1,
          ),
          StepsGameData(allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ], initNumbers: [
            1
          ], withFixedEquation: [
            1,
            1,
            1, //TODO -1 matchuje z 1 trzeba poprawic boarda xD
            -1,
            -1,
            -1
          ], firstTask: _taskC1),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Zrobimy coś dziwnego', seconds: 1.5),
    NextMsg(text: 'Zamień 2 w 1+1', seconds: 1.5),
    NextMsg(text: 'Scrolluj szare', seconds: 5),
    NextMsg(text: 'Ma powstać 1 + 1.', seconds: 5),
    NextMsg(text: 'Scrolluj szare'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [1, 1]), task: _taskA2)
  ],
);

var _taskA2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Znowu rozbijemy liczbę.', seconds: 3),
    NextMsg(text: 'Zamień -3 w -1 -1 -1.', seconds: 3),
    NextMsg(text: 'Scrolluj szare', seconds: 5),
    NextMsg(text: 'Ma powstać -1 - 1 - 1.', seconds: 5),
    NextMsg(text: 'Scrolluj szare'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [-1, -1, -1]),
        task: _taskB2)
  ],
);

var _taskB2 = Task(instructions: [
  NextMsg(text: 'Najs.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskC1 = Task(
  instructions: [
    NextMsg(text: 'Teraz będzie dopakowany przykład', seconds: 1.5),
    NextMsg(text: 'Narób dużo strzałek', seconds: 1.5),
    NextMsg(text: 'Ale, mają się zgadzać z górą', seconds: 5),
    NextMsg(text: 'Ma powstać 1 + 1 + 1 - 1 - 1 - 1.', seconds: 5),
    NextMsg(text: 'Scrolluj szare, żółte, klikaj co się da, w końcu się uda.'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [1, 1, 1, -1, -1, -1]),
        task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'No i elegancko.', seconds: 2),
  EndMsg(),
], onEvents: []);
