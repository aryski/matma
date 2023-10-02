import 'package:bloc/bloc.dart';
import 'package:matma/steps_simulation/items/arrow/cubit/arrow_state.dart';
import 'package:matma/task_simulation/cubit/task.dart';
import 'package:matma/task_simulation/cubit/tutorial.dart';

class TaskSimulationCubit extends Cubit<String> {
  TaskSimulationCubit() : super('Hejka.') {
    planTask(firstTutorialTask);
  }
  List<GameEvents> recent = [];
  Task currentTask = firstTutorialTask;
  // Task currentTask;
  int ind = 0;

  void inserted(Direction direction) {
    //TODO
    //insertion occured
    if (direction == Direction.up) {
      recent.add(GameEvents.insertedUp);
      _nextTask();
    } else if (direction == Direction.down) {
      recent.add(GameEvents.insertedDown);
      _nextTask();
    }
  }

  void insertedOpposite() {
    recent.add(GameEvents.insertedOpposite);
    _nextTask();
  }

  void merged() {
    recent.add(GameEvents.merged);
    _nextTask();
  }

  void splited() {
    recent.add(GameEvents.splited);
    _nextTask();
  }

  void scrolled() {
    recent.add(GameEvents.scrolled);
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
    var currentInd = ind;
    for (var instruction in t.instructions) {
      if (currentInd == ind) {
        emit(instruction.text);
        if (instruction.time != null) {
          await Future.delayed(instruction.time!);
        }
      } else {
        break;
      }
    }
  }
}
