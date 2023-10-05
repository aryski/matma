import 'package:matma/task_simulation/task.dart';

var _endOppositeAddTask = Task(instructions: [
  ContinuingInstruction(
      text: 'Udało Ci się dodać przeciwną strzałkę!',
      time: const Duration(seconds: 3)),
  ContinuingInstruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Jesteś już gotowy.', time: const Duration(seconds: 2)),
  ContinuingInstruction(text: 'bambiku.', time: const Duration(seconds: 2)),
  EndInstruction(),
], onEvents: []);

var _endScrollSplitedTaskHandleOpposite = Task(instructions: [
  ContinuingInstruction(
      text: 'Udało Ci się rozdzielić liczbę!',
      time: const Duration(seconds: 3)),
  ContinuingInstruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Jeszcze tylko ostatni quest.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Scrolluj po żółtym.', time: const Duration(seconds: 10)),
  ContinuingInstruction(text: '', time: Duration.zero),
], onEvents: [
  OnEvent(requiredEvent: GameEvents.insertedOpposite, task: _endOppositeAddTask)
]);

var _endScrollMergedTaskHandleOpposite = Task(instructions: [
  ContinuingInstruction(
      text: 'Udało Ci się zredukować liczby!',
      time: const Duration(seconds: 3)),
  ContinuingInstruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Jeszcze tylko ostatni quest.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Scrolluj po żółtym.', time: const Duration(seconds: 10)),
  ContinuingInstruction(text: '', time: Duration.zero),
], onEvents: [
  OnEvent(requiredEvent: GameEvents.insertedOpposite, task: _endOppositeAddTask)
]);

var _performSplitedTask = Task(instructions: [
  ContinuingInstruction(
      text: 'Udało Ci się zredukować liczby!',
      time: const Duration(seconds: 3)),
  ContinuingInstruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Znajdź szare między takim samym kolorem i scrolluj w górę.',
      time: const Duration(seconds: 7)),
  ContinuingInstruction(
      text: 'Strzałki muszą mieć takie same kolory.',
      time: const Duration(seconds: 7)),
], onEvents: [
  OnEvent(
      requiredEvent: GameEvents.splited,
      task: _endScrollSplitedTaskHandleOpposite)
]);
var _performMergedTask = Task(instructions: [
  ContinuingInstruction(
      text: 'Udało Ci się rozdzielić liczbę!',
      time: const Duration(seconds: 3)),
  ContinuingInstruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  ContinuingInstruction(
      text: 'Znajdź szare między różnymi strzałkami i scrolluj w dół.',
      time: const Duration(seconds: 7)),
  ContinuingInstruction(
      text: 'Strzałki muszą mieć różne kolory.',
      time: const Duration(seconds: 7)),
], onEvents: [
  OnEvent(
      requiredEvent: GameEvents.merged,
      task: _endScrollMergedTaskHandleOpposite)
]);

var _playGreyTask = Task(
  instructions: [
    ContinuingInstruction(
        text: 'Tak trzymaj!', time: const Duration(seconds: 2)),
    ContinuingInstruction(
        text: 'Pobaw się scrollem na szarych.',
        time: const Duration(seconds: 7)),
    ContinuingInstruction(
        text: 'Najedź na szare i scrolluj w przód i w tył.',
        time: const Duration(seconds: 7)),
    ContinuingInstruction(
        text: 'Spróbuj pomiędzy takimi samymi strzałkami.',
        time: const Duration(seconds: 7)),
    ContinuingInstruction(
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
    ContinuingInstruction(text: 'Nieźle.', time: const Duration(seconds: 2)),
    ContinuingInstruction(
        text: 'Przytrzymaj czerwoną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    ContinuingInstruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEvents.insertedDown, task: _playGreyTask)
  ],
);
var _insertGreenTask = Task(
  instructions: [
    ContinuingInstruction(text: 'Hejka.', time: const Duration(seconds: 3)),
    ContinuingInstruction(
        text: 'Przytrzymaj zieloną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    ContinuingInstruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: GameEvents.insertedUp, task: _insertRedTask)
  ],
);

var firstTutorialTask = _insertGreenTask;
