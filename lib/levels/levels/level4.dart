import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level5.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 4
// Splitting numbers.
Level getLevel4() {
  return Level(
    next: getLevel5(),
    data: LevelData(
      name: 'Poziom 4',
      icon: Icons.call_split_rounded,
      ind: 4,
      gamesData: [
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ],
          initNumbers: [2],
          firstTask: _taskA1,
        ),
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ],
          initNumbers: [-3],
          firstTask: _taskB1,
        ),
        StepsGameData(allowedOps: [
          StepsGameOps.splitJoinArrows,
          StepsGameOps.addArrowUp,
          StepsGameOps.addArrowDown,
          StepsGameOps.addOppositeArrow
        ], initNumbers: [
          1
        ], withFixedEquation: [
          1,
          1,
          1,
          -1,
          -1,
          -1
        ], firstTask: _taskC1),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Zrobimy coś dziwnego', seconds: 1.5),
    NextPrompt(text: 'Zamień 2 w 1+1', seconds: 1.5),
    NextPrompt(text: 'Scrolluj ciemnozielone', seconds: 5),
    NextPrompt(text: 'Ma powstać 1 + 1.', seconds: 5),
    NextPrompt(text: 'Scrolluj ciemnozielone'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1, 1]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Znowu rozbijemy liczbę.', seconds: 3),
    NextPrompt(text: 'Zamień -3 w -1 -1 -1.', seconds: 3),
    NextPrompt(text: 'Scrolluj ciemnoczerwone', seconds: 5),
    NextPrompt(text: 'Ma powstać -1 - 1 - 1.', seconds: 5),
    NextPrompt(text: 'Scrolluj ciemnoczerwone'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-1, -1, -1]),
        miniQuest: _taskB2)
  ],
);

var _taskB2 = MiniQuest(prompts: [
  NextPrompt(text: 'Najs.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskC1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Teraz będzie dopakowany przykład', seconds: 1.5),
    NextPrompt(text: 'Narób dużo strzałek', seconds: 1.5),
    NextPrompt(text: 'Ale, mają się zgadzać z górą', seconds: 5),
    NextPrompt(text: 'Ma powstać 1 + 1 + 1 - 1 - 1 - 1.', seconds: 5),
    NextPrompt(text: 'Scrolluj podłogi, klikaj co się da, w końcu się uda.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1, 1, 1, -1, -1, -1]),
        miniQuest: _taskC2)
  ],
);

var _taskC2 = MiniQuest(prompts: [
  NextPrompt(text: 'No i elegancko.', seconds: 2),
  EndPrompt(),
], choices: []);
