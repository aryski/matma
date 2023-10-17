import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level1.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Level(
      next: const Level1(),
      data: LevelData(name: 'Tutorial', gamesData: [
        StepsGameData(
            initNumbers: [3, -2],
            firstTask: _task1,
            allowedOps: StepsGameOps.values),
      ]),
    );
  }
}

var _task1 = Task(
  instructions: [
    NextMsg(text: 'Hejka.', seconds: 3),
    NextMsg(text: 'Przytrzymaj zieloną strzałkę i puść.', seconds: 7),
    NextMsg(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [OnEvent(requiredEvent: GameEventInsertedUp(), task: _task2)],
);

var _task2 = Task(
  instructions: [
    NextMsg(text: 'Nieźle.', seconds: 2),
    NextMsg(text: 'Przytrzymaj czerwoną strzałkę i puść.', seconds: 7),
    NextMsg(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [OnEvent(requiredEvent: GameEventInsertedDown(), task: _task3)],
);

var _task3 = Task(
  instructions: [
    NextMsg(text: 'Tak trzymaj!', seconds: 2),
    NextMsg(text: 'Pobaw się scrollem na szarych.', seconds: 7),
    NextMsg(text: 'Najedź na szare i scrolluj w przód i w tył.', seconds: 7),
    NextMsg(text: 'Spróbuj pomiędzy takimi samymi strzałkami.', seconds: 7),
    NextMsg(text: 'Spróbuj pomiędzy strzałkami rożnych kolorów.', seconds: 7),
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEventMerged(), task: _task4b),
    OnEvent(requiredEvent: GameEventSplited(), task: _task4a)
  ],
);

var _task4a = Task(instructions: [
  NextMsg(text: 'Udało Ci się rozdzielić liczbę!', seconds: 3),
  NextMsg(text: 'Gratki.', seconds: 2),
  NextMsg(
      text: 'Znajdź szare między różnymi strzałkami i scrolluj w dół.',
      seconds: 7),
  NextMsg(text: 'Strzałki muszą mieć różne kolory.', seconds: 7),
], onEvents: [
  OnEvent(requiredEvent: GameEventMerged(), task: _task5a)
]);

var _task4b = Task(instructions: [
  NextMsg(text: 'Udało Ci się zredukować liczby!', seconds: 3),
  NextMsg(text: 'Gratki.', seconds: 2),
  NextMsg(
      text: 'Znajdź szare między takim samym kolorem i scrolluj w górę.',
      seconds: 7),
  NextMsg(text: 'Strzałki muszą mieć takie same kolory.', seconds: 7),
], onEvents: [
  OnEvent(requiredEvent: GameEventSplited(), task: _task5b)
]);

var _task5a = Task(instructions: [
  NextMsg(text: 'Udało Ci się zredukować liczby!', seconds: 3),
  NextMsg(text: 'Gratki.', seconds: 2),
  NextMsg(text: 'Jeszcze tylko ostatni quest.', seconds: 2),
  NextMsg(text: 'Scrolluj po żółtym.', seconds: 10),
  NextMsg(text: '', seconds: 0),
], onEvents: [
  OnEvent(requiredEvent: GameEventInsertedOpposite(), task: _task6)
]);

var _task5b = Task(instructions: [
  NextMsg(text: 'Udało Ci się rozdzielić liczbę!', seconds: 3),
  NextMsg(text: 'Gratki.', seconds: 2),
  NextMsg(text: 'Jeszcze tylko ostatni quest.', seconds: 2),
  NextMsg(text: 'Scrolluj po żółtym.', seconds: 10),
  NextMsg(text: '', seconds: 0),
], onEvents: [
  OnEvent(requiredEvent: GameEventInsertedOpposite(), task: _task6)
]);

var _task6 = Task(instructions: [
  NextMsg(text: 'Udało Ci się dodać przeciwną strzałkę!', seconds: 3),
  NextMsg(text: 'Gratki.', seconds: 2),
  NextMsg(text: 'Jesteś już gotowy.', seconds: 2),
  NextMsg(text: 'bambiku.', seconds: 2),
  EndMsg(),
], onEvents: []);
