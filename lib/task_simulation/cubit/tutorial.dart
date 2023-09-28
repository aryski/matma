import 'package:matma/task_simulation/cubit/task.dart';

var _endScrollSplitedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się rozdzielić liczbę!',
      time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(text: 'Jesteś już gotowy.', time: const Duration(seconds: 2)),
  Instruction(text: 'bambiku.', time: const Duration(seconds: 2)),
  Instruction(text: '', time: Duration.zero),
], onEvents: []);

var _endScrollMergedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się zredukować liczby!',
      time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(text: 'Jesteś już gotowy.', time: const Duration(seconds: 2)),
  Instruction(text: 'bambiku.', time: const Duration(seconds: 2)),
  Instruction(text: '', time: Duration.zero),
], onEvents: []);

var _performSplitedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się połączyć liczbę!', time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(
      text: 'Znajdź szare między takim samym kolorem i scrolluj w górę.',
      time: const Duration(seconds: 7)),
  Instruction(
      text: 'Strzałki muszą mieć takie same kolory.',
      time: const Duration(seconds: 7)),
], onEvents: [
  OnEvent(requiredEvent: GameEvents.splited, task: _endScrollSplitedTask)
]);
var _performMergedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się rozdzielić liczbę!',
      time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(
      text: 'Znajdź szare między różnymi strzałkami i scrolluj w dół.',
      time: const Duration(seconds: 7)),
  Instruction(
      text: 'Strzałki muszą mieć różne kolory.',
      time: const Duration(seconds: 7)),
], onEvents: [
  OnEvent(requiredEvent: GameEvents.merged, task: _endScrollMergedTask)
]);

var _playGreyTask = Task(
  instructions: [
    Instruction(text: 'Tak trzymaj!', time: const Duration(seconds: 2)),
    Instruction(
        text: 'Pobaw się scrollem na szarych.',
        time: const Duration(seconds: 7)),
    Instruction(
        text: 'Najedź na szare i scrolluj w przód i w tył.',
        time: const Duration(seconds: 7)),
    Instruction(
        text: 'Spróbuj pomiędzy takimi samymi strzałkami.',
        time: const Duration(seconds: 7)),
    Instruction(
        text: 'Spróbuj pomiędzy strzałkami rożnych kolorów.',
        time: const Duration(seconds: 7)),
  ],
  onEvents: [
    OnEvent(
      requiredEvent: GameEvents.merged,
      task: _performSplitedTask,
    ),
    OnEvent(requiredEvent: GameEvents.splited, task: _performMergedTask)
  ],
);

var _insertRedTask = Task(
  instructions: [
    Instruction(text: 'Nieźle.', time: const Duration(seconds: 2)),
    Instruction(
        text: 'Przytrzymaj czerwoną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    Instruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEvents.insertedDown, task: _playGreyTask)
  ],
);
var _insertGreenTask = Task(
  instructions: [
    Instruction(text: 'Hejka.', time: const Duration(seconds: 3)),
    Instruction(
        text: 'Przytrzymaj zieloną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    Instruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEvents.insertedUp, task: _insertRedTask)
  ],
);

var firstTutorialTask = _insertGreenTask;
