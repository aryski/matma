import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/quests/cubit/quests_state.dart';
import 'package:matma/quests/game_events/game_events.dart';
import 'package:matma/quests/task.dart';
import 'package:matma/levels/levels/tutorial.dart';

class QuestsCubit extends Cubit<QuestsState> {
  final LevelCubit parent;
  QuestsCubit(this.firstTask, this.parent)
      : currentTask = firstTask,
        super(QuestsStateDisplay(text: 'Hejka.')) {
    planTask(firstTask);
  }

  final Task firstTask;
  List<GameEvent> recent = [];
  Task currentTask;
  int ind = 0;

  void inserted(Direction direction) {
    if (direction == Direction.up) {
      recent.add(GameEventInsertedUp());
      _nextTask();
    } else if (direction == Direction.down) {
      recent.add(GameEventInsertedDown());
      _nextTask();
    }
  }

  void insertedOpposite() {
    recent.add(GameEventInsertedOpposite());
    _nextTask();
  }

  void equationValue(List<int> numbers) {
    recent.add(GameEventEquationValue(numbers: numbers));
    _nextTask();
  }

  void merged() {
    recent.add(GameEventMerged());
    _nextTask();
  }

  void splited() {
    recent.add(GameEventSplited());
    _nextTask();
  }

  void scrolled() {
    recent.add(GameEventScrolled());
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
      if (instruction is NextMsg) {
        if (currentInd == ind) {
          emit(QuestsStateDisplay(text: instruction.text));
          if (instruction.time != Duration.zero) {
            await Future.delayed(instruction.time);
          }
        } else {
          break;
        }
      } else if (instruction is EndMsg) {
        parent.nextGame();
        emit(QuestsStateEndLevel(text: 'Koniec zabawy'));
      }
    }
  }
}
