import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

// Level 4
// Matching steps to equation.
//Zadanie 4
//Rozbijanie 2 na 1+1, rozbijanie -3 na -1,-1,-1, rozbijanie 3-3 na 1 + 1 + 1 - 1 - 1 -1
//błąd w steps game blocu z łączeniem jak jest -1,-1,-1 i pierwsze dwie laczymy wychodzi 3-3 xD
class Level5 extends StatelessWidget {
  const Level5({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      data: LevelData(
        name: 'Level5',
        gamesData: [
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow
            ],
            initNumbers: [1, 1],
            firstTask: _taskA1,
          ),
          StepsGameData(
            allowedOps: [
              StepsGameOps.splitJoinArrows,
              StepsGameOps.addArrowUp,
              StepsGameOps.addArrowDown,
              StepsGameOps.addOppositeArrow
            ],
            initNumbers: [-1, -1, -1],
            firstTask: _taskB1,
          ),
          StepsGameData(allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ], initNumbers: [
            1,
            1,
            1,
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
    NextMsg(text: 'Lepiej łączyć niż dzielić.', seconds: 1.5),
    NextMsg(text: 'No więc będziemy teraz łączyć.', seconds: 1.5),
    NextMsg(text: 'Scrolluj długie szare w krótkie', seconds: 3),
    NextMsg(text: 'Ma powstać 2', seconds: 5),
    NextMsg(text: 'Scrolluj długie szare w krótkie'),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventEquationValue(numbers: [2]), task: _taskA2)
  ],
);

var _taskA2 = Task(instructions: [
  NextMsg(text: 'Git.', seconds: 1.5),
  EndMsg(),
], onEvents: []);

var _taskB1 = Task(
  instructions: [
    NextMsg(text: 'Znowu połączymy liczbę.', seconds: 3),
    NextMsg(text: 'Zamień -1 -1 -1 w -3.', seconds: 3),
    NextMsg(text: 'Scrolluj długie szare w krótkie', seconds: 5),
    NextMsg(text: 'Ma powstać -3', seconds: 5),
    NextMsg(text: 'Scrolluj szare'),
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
    NextMsg(text: 'No i zwijamy wszystko', seconds: 1.5),
    NextMsg(text: 'Szare mają być krótie', seconds: 1.5),
    NextMsg(text: 'Ma powstać 3-3.', seconds: 5),
    NextMsg(text: 'Scrolluj szare, w końcu się uda.'),
  ],
  onEvents: [
    OnEvent(
        requiredEvent: GameEventEquationValue(numbers: [3, -3]), task: _taskC2)
  ],
);

var _taskC2 = Task(instructions: [
  NextMsg(text: 'No i elegancko.', seconds: 2),
  EndMsg(),
], onEvents: []);