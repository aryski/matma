import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/common/items/game_item/cubit/game_item_property.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/prompts/items/line/cubit/line_cubit.dart';
import 'package:matma/steps_game/items/arrow/cubit/arrow_state.dart';
import 'package:matma/prompts/cubit/prompts_state.dart';
import 'package:matma/prompts/game_events/game_events.dart';
import 'package:matma/prompts/task.dart';

class PromptsCubit extends Cubit<PromptsState> {
  final LevelCubit parent;
  PromptsCubit(this.firstTask, this.parent, this.topPadding)
      : currentTask = firstTask,
        super(PromptsState(lines: [])) {
    addLine("");
    planTask(firstTask);
  }
  final Task firstTask;
  final double topPadding;
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
          addLine(instruction.text);
          if (instruction.milliseconds != Duration.zero) {
            await Future.delayed(instruction.milliseconds);
          }
        } else {
          break;
        }
      } else if (instruction is EndMsg) {
        parent.nextGame();
        addLine("");
      }
    }
  }

  void addLine(String text) {
    for (var line in state.lines) {
      line.updatePosition(const Offset(0, -0.04));
    }
    for (int i = 0; i < state.lines.length; i++) {
      state.lines[i].updatePosition(const Offset(0, -0.005));

      if (i < state.lines.length - 1) {
        state.lines[i].setOpacity(0, milliseconds: 100);
      } else {
        state.lines[i].setOpacity(0.5, milliseconds: 200);
      }
    }
    var newLine = LineCubit(LineState(
        text: text,
        id: UniqueKey(),
        position: AnimatedProp.zero(value: Offset(0.0, topPadding)),
        size: AnimatedProp.zero(value: const Offset(1.0, 0.04)),
        opacity: AnimatedProp.zero(value: 0.0),
        radius: 15.0));

    newLine.setOpacity(1.0, delayInMillis: 20, milliseconds: 400);
    emit(state.copyWith(lines: [...state.lines, newLine]));
  }
}
