import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level4.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 3
// Matching steps to equation.

Level getLevel3() {
  return Level(
    next: getLevel4(),
    data: LevelData(
      icon: Icons.route_rounded,
      ind: 3,
      name: 'Poziom 3',
      gamesData: [
        StepsGameData(
          allowedOps: [StepsGameOps.addArrowUp],
          initNumbers: [1],
          withFixedEquation: [3],
          firstTask: _taskA1,
        ),
        StepsGameData(
          allowedOps: [StepsGameOps.addArrowDown],
          initNumbers: [-1],
          withFixedEquation: [-3],
          firstTask: _taskB1,
        ),
        StepsGameData(allowedOps: [
          StepsGameOps.addArrowDown,
          StepsGameOps.addArrowUp,
          StepsGameOps.addOppositeArrow
        ], initNumbers: [
          1
        ], withFixedEquation: [
          3,
          -2,
          4,
          -1
        ], firstTask: _taskC1),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Widzisz cyfrę?', seconds: 3),
    NextPrompt(text: 'Zrób tyle strzałek.', seconds: 7),
    NextPrompt(text: 'Trzy zielone strzałki.')
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [3]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Zrób -3 strzałki.', seconds: 7),
    NextPrompt(text: 'Trzy czerwone strzałki.')
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-3]),
        miniQuest: _taskB2)
  ],
);

var _taskB2 = MiniQuest(prompts: [
  NextPrompt(text: 'Najs.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskC1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Znowu.', seconds: 1),
    NextPrompt(text: 'Klikaj strzałki, aby pokolorować cyferki.', seconds: 6),
    NextPrompt(text: 'Hop hop.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [3, -2, 4, -1]),
        miniQuest: _taskC2)
  ],
);

var _taskC2 = MiniQuest(prompts: [
  NextPrompt(text: 'No i elegancko.', seconds: 2),
  EndPrompt(),
], choices: []);
