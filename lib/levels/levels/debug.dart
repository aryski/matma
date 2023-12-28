import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quest/items/mini_quest.dart';

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

var _taskA1 = MiniQuest(prompts: [
  NextPrompt(
    text: 'Hej potężny programisto!',
  ),
], choices: []);

Level getDebugLevelTrivial() {
  return Level(
    data: LevelData(
      icon: Icons.computer_rounded,
      ind: 0,
      name: 'Debug Trivial',
      gamesData: [
        StepsGameData(
          allowedOps: StepsGameOps.values,
          initNumbers: [1],
          firstTask: _taskB1,
        ),
      ],
    ),
  );
}

var _taskB1 = MiniQuest(prompts: [
  NextPrompt(
    text: 'Hej potężny programisto!',
  ),
  EndPrompt()
], choices: []);
