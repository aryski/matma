import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level2.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 1
// Matching steps to shaded fixed steps.

Level getLevel1() {
  return Level(
    next: getLevel2(),
    data: LevelData(
      icon: Icons.add_box_outlined,
      ind: 1,
      name: 'Poziom 1',
      gamesData: [
        StepsGameData(
            allowedOps: [StepsGameOps.addArrowUp],
            initNumbers: [1],
            shadedSteps: [3],
            firstTask: _taskA1,
            withEquation: false),
        StepsGameData(
            allowedOps: [StepsGameOps.addArrowDown],
            initNumbers: [-1],
            shadedSteps: [-3],
            firstTask: _taskB1,
            withEquation: false),
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
        ], firstTask: _taskC1, withEquation: false),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Hejka.', seconds: 1.5),
    NextPrompt(text: 'Klikaj na zielone strzałki.', seconds: 1.5),
    NextPrompt(text: 'Zrób obrazek taki jak w tle.', seconds: 7),
    NextPrompt(text: 'Mają być trzy zielone strzałki.')
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [3]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(prompts: [
  NextPrompt(text: 'Udało Ci się!', seconds: 2),
  NextPrompt(text: 'Spróbujmy czegoś innego.', seconds: 2),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Znowu.', seconds: 1),
    NextPrompt(text: 'Zrób obrazek taki jak w tle.', seconds: 7),
    NextPrompt(text: 'Mają być trzy czerwone strzałki.')
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-3]),
        miniQuest: _taskB2)
  ],
);

var _taskB2 = MiniQuest(prompts: [
  NextPrompt(text: 'Najs.', seconds: 2),
  NextPrompt(text: 'Kolejny przykład.', seconds: 2),
  EndPrompt(),
], choices: []);

var _taskC1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Znowu.', seconds: 1),
    NextPrompt(text: 'Dojdź do obrazka w tle.', seconds: 2.5),
    NextPrompt(text: 'Klikaj w złote łączenia.')
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
