import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level6.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 5
// Joining numbers.
Level getLevel5() {
  return Level(
    next: getLevel6(),
    data: LevelData(
      name: 'Poziom 5',
      icon: Icons.join_full_rounded,
      ind: 5,
      gamesData: [
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ],
          initNumbers: [1, 1],
          firstTask: _taskA1,
        ),
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.addArrowUp,
            StepsGameOps.addArrowDown,
            StepsGameOps.addOppositeArrow
          ],
          initNumbers: [-1, -1, -1],
          firstTask: _taskB1,
        ),
        StepsGameData(allowedOps: [
          StepsGameOps.splitJoinArrows,
          StepsGameOps.addArrowUp,
          StepsGameOps.addArrowDown,
          StepsGameOps.addOppositeArrow
        ], initNumbers: [
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
    NextPrompt(text: 'Lepiej łączyć niż dzielić.', seconds: 1.5),
    NextPrompt(text: 'No więc będziemy teraz łączyć.', seconds: 1.5),
    NextPrompt(text: 'Scrolluj długie szare w krótkie, kolorowe', seconds: 3),
    NextPrompt(text: 'Ma powstać 2', seconds: 5),
    NextPrompt(text: 'Scrolluj długie szare w krótkie, kolorowe'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [2]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Znowu połączymy liczbę.', seconds: 3),
    NextPrompt(text: 'Zamień -1 -1 -1 w -3.', seconds: 3),
    NextPrompt(text: 'Scrolluj długie szare w krótkie, kolorowe', seconds: 5),
    NextPrompt(text: 'Ma powstać -3', seconds: 5),
    NextPrompt(text: 'Scrolluj szare'),
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
    NextPrompt(text: 'No i zwijamy wszystko', seconds: 1.5),
    NextPrompt(text: 'Szare mają być kolorowe', seconds: 1.5),
    NextPrompt(text: 'Ma powstać 3 - 3.', seconds: 5),
    NextPrompt(text: 'Scrolluj szare, w końcu się uda.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [3, -3]),
        miniQuest: _taskC2)
  ],
);

var _taskC2 = MiniQuest(prompts: [
  NextPrompt(text: 'No i elegancko.', seconds: 2),
  EndPrompt(),
], choices: []);
