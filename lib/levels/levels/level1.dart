import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

//Zadanie 1
//Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie
//Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie i ujemne
//Od strzałki do dopasowania do kształtu z ciemnego rysunku, liczby dodatnie i ujemne i długie

class Level1 extends StatelessWidget {
  const Level1({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level2(),
      data: LevelData(
        name: 'Level1',
        gamesData: [
          StepsGameData(
              allowedOps: [StepsGameOps.addArrowUp],
              initNumbers: [1],
              shadedSteps: [3],
              firstTask: _taskA1,
              withEquation: false),
          StepsGameData(
              allowedOps: [StepsGameOps.addArrowDown],
              initNumbers: [-1],
              shadedSteps: [-3],
              firstTask: _taskB1,
              withEquation: false),
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
          ], firstTask: _taskC1, withEquation: false),
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
