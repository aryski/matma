import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level3.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 2
// Matching steps to shaded fixed steps, with above equation.
// TODO maybe better "in" animation of the equation.
Level getLevel2() {
  return Level(
    next: getLevel3(),
    data: LevelData(
      icon: Icons.developer_board_rounded,
      ind: 2,
      name: 'Poziom 2',
      gamesData: [
        StepsGameData(
            allowedOps: [StepsGameOps.addArrowUp],
            initNumbers: [1],
            shadedSteps: [3],
            firstTask: _taskA1,
            withEquation: true),
        StepsGameData(
            allowedOps: [StepsGameOps.addArrowDown],
            initNumbers: [-1],
            shadedSteps: [-3],
            firstTask: _taskB1,
            withEquation: true),
        StepsGameData(allowedOps: [
          StepsGameOps.addArrowDown,
          StepsGameOps.addArrowUp,
          StepsGameOps.addOppositeArrow
        ], initNumbers: [
          1
        ], shadedSteps: [
          3,
          -2,
          4,
          -1
        ], firstTask: _taskC1, withEquation: true),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Widzisz cyfrę?', seconds: 1.5),
    NextPrompt(text: 'Obserwuj cyfrę!', seconds: 1.5),
    NextPrompt(text: 'Zrób obrazek jak w tle.', seconds: 7),
    NextPrompt(text: 'Trzy zielone strzałki obok siebie.')
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
    NextPrompt(text: 'Znowu.', seconds: 1.5),
    NextPrompt(text: 'Zrób obrazek taki jak w tle.', seconds: 1.5),
    NextPrompt(text: 'Trzy zielone strzałki obok siebie.')
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
    NextPrompt(text: 'Znowu to samo.', seconds: 2),
    NextPrompt(text: 'Patrz na cyferki.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [3, -2, 4, -1]),
        miniQuest: _taskC2)
  ],
);

var _taskC2 = MiniQuest(prompts: [
  NextPrompt(text: 'Gites majonez.', seconds: 2),
  EndPrompt(),
], choices: []);
