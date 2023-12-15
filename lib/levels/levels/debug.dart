import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/prompts/task.dart';

// Level 7
// Reducing numbers in a cascade way.

Level getDebugLevel() {
  return Level(
    data: LevelData(
      icon: Icons.computer_rounded,
      ind: 0,
      name: 'Debug',
      gamesData: [
        StepsGameData(
          allowedOps: StepsGameOps.values,
          initNumbers: [1, -2, 4, -5, 1, -5, 6, -3, 3, 3],
          firstTask: _taskA1,
        ),
      ],
    ),
  );
}

var _taskA1 = Task(instructions: [
  NextMsg(
    text: 'Hej potężny programisto!',
  ),
], onEvents: []);
