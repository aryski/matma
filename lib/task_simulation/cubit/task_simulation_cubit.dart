import 'package:bloc/bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';

class OnEvent {
  final PossibleEvents requiredEvent;
  final Task task;

  OnEvent({required this.requiredEvent, required this.task});
}

class Instruction {
  final String text;
  final Duration? time;

  Instruction({required this.text, this.time});
}

class Task {
  final List<Instruction> instructions;
  final List<OnEvent> onEvents;

  OnEvent? isDone(List<PossibleEvents> recentEvents) {
    for (var onEvent in onEvents) {
      if (recentEvents.contains(onEvent.requiredEvent)) {
        return onEvent;
      }
    }
    return null;
  }

  Task({required this.instructions, required this.onEvents});
}

enum PossibleEvents {
  insertedUp,
  insertedDown,
  merged,
  splited,
  scrolled,
  mergedOrSplited
}

var endScrollSplitedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się rozdzielić liczbę!',
      time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(text: 'Jesteś już gotowy.', time: const Duration(seconds: 2)),
  Instruction(text: 'bambiku.', time: const Duration(seconds: 2)),
  Instruction(text: '', time: Duration.zero),
], onEvents: []);

var endScrollMergedTask = Task(instructions: [
  Instruction(
      text: 'Udało Ci się zredukować liczby!',
      time: const Duration(seconds: 3)),
  Instruction(text: 'Gratki.', time: const Duration(seconds: 2)),
  Instruction(text: 'Jesteś już gotowy.', time: const Duration(seconds: 2)),
  Instruction(text: 'bambiku.', time: const Duration(seconds: 2)),
  Instruction(text: '', time: Duration.zero),
], onEvents: []);

var performSplitedTask = Task(instructions: [
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
  OnEvent(requiredEvent: PossibleEvents.splited, task: endScrollSplitedTask)
]);
var performMergedTask = Task(instructions: [
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
  OnEvent(requiredEvent: PossibleEvents.merged, task: endScrollMergedTask)
]);

var playGreyTask = Task(
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
      requiredEvent: PossibleEvents.merged,
      task: performSplitedTask,
    ),
    OnEvent(requiredEvent: PossibleEvents.splited, task: performMergedTask)
  ],
);

var insertRedTask = Task(
  instructions: [
    Instruction(text: 'Nieźle.', time: const Duration(seconds: 2)),
    Instruction(
        text: 'Przytrzymaj czerwoną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    Instruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: PossibleEvents.insertedDown, task: playGreyTask)
  ],
);
var insertGreenTask = Task(
  instructions: [
    Instruction(text: 'Hejka.', time: const Duration(seconds: 3)),
    Instruction(
        text: 'Przytrzymaj zieloną strzałkę i puść.',
        time: const Duration(seconds: 7)),
    Instruction(text: 'Przytrzymaj ją dłużej i puść.')
  ],
  onEvents: [
    OnEvent(requiredEvent: PossibleEvents.insertedUp, task: insertRedTask)
  ],
);

class TaskSimulationCubit extends Cubit<String> {
  TaskSimulationCubit() : super('Hejka.') {
    planTask(insertGreenTask);
  }
  List<PossibleEvents> recent = [];
  Task currentTask = insertGreenTask;
  // Task currentTask;
  int ind = 0;

  void inserted(Direction direction) {
    //TODO
    //insertion occured
    if (direction == Direction.up) {
      recent.add(PossibleEvents.insertedUp);
      _nextTask();
    } else if (direction == Direction.down) {
      recent.add(PossibleEvents.insertedDown);
      _nextTask();
    }
  }

  void merged() {
    recent.add(PossibleEvents.mergedOrSplited);
    recent.add(PossibleEvents.merged);
    _nextTask();
  }

  void splited() {
    recent.add(PossibleEvents.mergedOrSplited);
    recent.add(PossibleEvents.splited);
    _nextTask();
  }

  void scrolled() {
    recent.add(PossibleEvents.scrolled);
    //todo activation because event came, can break planned task
    _nextTask();
  }

  void _nextTask() async {
    var onEvent = currentTask.isDone(recent);
    if (onEvent != null) {
      ind++;
      recent.clear();
      planTask(onEvent.task);
      currentTask = onEvent.task;
    }
  }

  void planTask(Task t) async {
    //task planer for current task
    var currentInd = ind;

    for (var instruction in t.instructions) {
      if (currentInd == ind) {
        emit(instruction.text);
        if (instruction.time != null) {
          await Future.delayed(instruction.time!);
        }
      } else {
        break; //else we break
      }
    }
  }
}
