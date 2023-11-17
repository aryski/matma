import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

// Level 6
// Reducing numbers.

class Level6 extends StatelessWidget {
  const Level6({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level7(),
      data: LevelData(
        name: 'Level6',
        gamesData: [
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow,
              StepsGameOps.reduceArrows
            ],
            initNumbers: [2, -1],
            firstTask: _taskA1,
          ),
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow,
              StepsGameOps.reduceArrows
            ],
            initNumbers: [4, -3],
            firstTask: _taskB1,
          ),
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow,
              StepsGameOps.reduceArrows
            ],
            initNumbers: [-4, 3],
            firstTask: _taskC1,
          ),
          StepsGameData(allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow,
            StepsGameOps.reduceArrows
          ], initNumbers: [
            1,
            5,
            -5,
            1,
            -6,
            6,
            -3
          ], firstTask: _taskD1),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Wiesz, że 1-1 = 0?', seconds: 1.5),
    NextMsg(text: 'Wykorzystamy to teraz.', seconds: 1.5),
    NextMsg(text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 3),
    NextMsg(text: 'Ma powstać 1', seconds: 5),
    NextMsg(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [1]), task: _taskA2)
  ],
);

var _taskA2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Teraz zrobimy to samo kilka razy.', seconds: 3),
    NextMsg(text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 3),
    NextMsg(text: 'Aż zostanie sama 1.', seconds: 5),
    NextMsg(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [1]), task: _taskB2)
  ],
);

var _taskB2 = Task(instructions: [
  NextMsg(text: 'Najs.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskC1 = Task(
  instructions: [
    NextMsg(text: 'Popatrz na to jak się zmienia równanie.', seconds: 1.5),
    NextMsg(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 1.5),
    NextMsg(text: 'Aż zostanie samo -1.', seconds: 5),
    NextMsg(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-1]), task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskD1 = Task(
  instructions: [
    NextMsg(text: 'No i zwijamy wszystko, aż zostanie -1', seconds: 1.5),
    NextMsg(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 1.5),
    NextMsg(text: 'Ma zostać -1.', seconds: 5),
    NextMsg(text: 'Scrolluj szare, w końcu się uda.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-1]), task: _taskD2)
  ],
);

var _taskD2 = Task(instructions: [
  NextMsg(text: 'No i elegancko.', seconds: 2),
  EndMsg(),
], onEvents: []);
