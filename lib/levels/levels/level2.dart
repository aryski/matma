import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

//Zadanie 2
//Od rysunku do strzałki i pokazanie, że wynik to zawsze fragment ostatnich strzałek spod/nad linii
//Wprowadzenie równania
//(moze tutaj najpierw pojawi się równanie, a rysunek będzie po paru sekundach, żeby zwrócić uwagę odbiorcy na równanie)
//Obliczenie tego samego co w a) ale z równaniem

class Level2 extends StatelessWidget {
  const Level2({super.key});
  @override
  Widget build(BuildContext context) {
    return Level(
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

//TODO przydałoby się móc oprócz wiadomości polecenia dodać wiadomośc notatkę,
//typu, że np zauważ dodatkowo coś oznacza coś itd xdddd, albo zawsze na koncu
//damy takie jak ta linia w tle?

var _taskA1 = Task(
  instructions: [
    NextMsg(text: 'Widzisz cyfrę na górze?', seconds: 3),
    NextMsg(text: 'Dojdź do obrazka w tle i ją obserwuj.', seconds: 7),
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
    NextMsg(text: 'Znowu dojdź do obrazka w tle.', seconds: 7),
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
