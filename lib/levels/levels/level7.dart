import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

// Level 7
// Reducing numbers in a cascade way.

class Level7 extends StatelessWidget {
  const Level7({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      data: LevelData(
        name: 'Level7',
        gamesData: [
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow,
              StepsGameOps.reduceArrows,
              StepsGameOps.reducingArrowsCascadedly
            ],
            initNumbers: [4, -3],
            firstTask: _taskA1,
          ),
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow,
              StepsGameOps.reduceArrows,
              StepsGameOps.reducingArrowsCascadedly
            ],
            initNumbers: [4, -3, -2, -3, 3],
            firstTask: _taskB1,
          ),
          StepsGameData(allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow,
            StepsGameOps.reduceArrows,
            StepsGameOps.reducingArrowsCascadedly
          ], initNumbers: [
            1,
            5,
            -5,
            1,
            -6,
            6,
            -3
          ], firstTask: _taskC1),
        ],
      ),
    );
  }
}

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Zamień 4 - 3 w 1 + 3 - 3', seconds: 3),
    NextMsg(text: 'Podziel 4 na 1 + 3 scrollem.', seconds: 3),
    NextMsg(text: 'Ma powstać 1 + 3 - 3', seconds: 5),
    NextMsg(text: 'Podziel 4 na 1 + 3 scrollem.'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [1, 3, -3]),
        task: _taskA2)
  ],
);

var _taskA2 = Task(
  instructions: [
    NextMsg(text: 'Teraz kliknij na szarą górkę.', seconds: 3),
    NextMsg(text: 'Dzięki temu zostanie ci 1.', seconds: 3),
    NextMsg(
        text: 'Kliknij na szarą górkę, albo scrolluj szare pomiędzy kolorami.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [1]), task: _taskA3)
  ],
);

var _taskA3 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Teraz zrobimy to samo kilka razy.', seconds: 3),
    NextMsg(text: 'Klikaj górki i dolinki.', seconds: 3),
    NextMsg(text: 'Używaj też scrolla.', seconds: 3),
    NextMsg(text: 'Aż zostanie samo -1.', seconds: 5),
    NextMsg(text: 'Klikaj górki i dolinki, używaj scrolla, aż zostanie -1.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-1]), task: _taskB2)
  ],
);

var _taskB2 = Task(instructions: [
  NextMsg(text: 'Najs.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskC1 = Task(
  instructions: [
    NextMsg(text: 'Popatrz na to jak się zmienia równanie.', seconds: 1.5),
    NextMsg(text: 'Klikaj górki i dolinki.', seconds: 3),
    NextMsg(text: 'Używaj też scrolla.', seconds: 3),
    NextMsg(text: 'Aż zostanie samo -1.', seconds: 5),
    NextMsg(text: 'Klikaj górki i dolinki, używaj scrolla, aż zostanie -1.'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [-1]), task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);
