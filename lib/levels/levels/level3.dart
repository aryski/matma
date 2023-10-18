//Zadanie 3
//Od strzałki do dopasowania do równania, liczby dodatnie
//Od strzałki do dopasowania do równania, liczby dodatnie i ujemne
//Od strzałki do dopasowania do równania, liczby dodatnie i ujemne i długie
//Żeby zrobić tak jak na równaniu xdddd
import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

class Level3 extends StatelessWidget {
  const Level3({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
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
          ], firstTask: _taskC1, withEquation: true),
        ],
      ),
    );
  }
}

//TODO przydałoby się móc oprócz wiadomości polecenia dodać wiadomośc notatkę,
//typu, że np zauwaZż dodatkowo coś oznacza coś itd xdddd, albo zawsze na koncu
//damy takie jak ta linia w tle?

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Widzisz cyfrę na górze?', seconds: 3),
    NextMsg(text: 'Narysuj tyle strzałek.', seconds: 7),
    NextMsg(text: 'Trzy zielone strzałki obok siebie.')
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
    NextMsg(text: 'Znowu narysuj cyferki strzałkami.', seconds: 7),
    NextMsg(text: 'Trzy zielone strzałki obok siebie.')
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
    NextMsg(text: 'Znowu to samo, cyferki strzałkami.'),
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
