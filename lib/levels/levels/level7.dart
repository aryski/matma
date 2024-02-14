import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 7
// Reducing numbers in a cascade way.

Level getLevel7() {
  return Level(
    data: LevelData(
      icon: Icons.area_chart_rounded,
      ind: 7,
      name: 'Poziom 7',
      gamesData: [
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.reduceArrows,
            StepsGameOps.reducingArrowsCascadedly
          ],
          initNumbers: [4, -3],
          firstTask: _taskA1,
        ),
        StepsGameData(
          allowedOps: [
            StepsGameOps.splitJoinArrows,
            StepsGameOps.reduceArrows,
            StepsGameOps.reducingArrowsCascadedly
          ],
          initNumbers: [4, -3, -2, -3, 3],
          firstTask: _taskB1,
        ),
        StepsGameData(allowedOps: [
          StepsGameOps.splitJoinArrows,
          StepsGameOps.reduceArrows,
          StepsGameOps.reducingArrowsCascadedly
        ], initNumbers: [
          1,
          5,
          -5,
          1,
          -6,
          6,
          -3
        ], firstTask: _taskC1),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Zamień 4 - 3 w 1 + 3 - 3', seconds: 3),
    NextPrompt(text: 'Podziel 4 na 1 + 3 scrollem.', seconds: 3),
    NextPrompt(text: 'Ma powstać 1 + 3 - 3'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1, 3, -3]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Teraz kliknij na szarą górkę.', seconds: 3),
    NextPrompt(text: 'Dzięki temu zostanie ci 1.', seconds: 3),
    NextPrompt(
        text: 'Kliknij na szarą górkę, albo scrolluj szare pomiędzy kolorami.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1]),
        miniQuest: _taskA3)
  ],
);

var _taskA3 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Teraz zrobimy to samo kilka razy.', seconds: 3),
    NextPrompt(text: 'Klikaj górki i dolinki.', seconds: 3),
    NextPrompt(text: 'Używaj też scrolla.', seconds: 3),
    NextPrompt(text: 'Aż zostanie samo -1.', seconds: 5),
    NextPrompt(text: 'Klikaj górki i dolinki, używaj scrolla, aż zostanie -1.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-1]),
        miniQuest: _taskB2)
  ],
);

var _taskB2 = MiniQuest(prompts: [
  NextPrompt(text: 'Najs.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskC1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Popatrz na to jak się zmienia równanie.', seconds: 1.5),
    NextPrompt(text: 'Klikaj górki i dolinki.', seconds: 3),
    NextPrompt(text: 'Używaj też scrolla.', seconds: 3),
    NextPrompt(text: 'Aż zostanie samo -1.', seconds: 5),
    NextPrompt(text: 'Klikaj górki i dolinki, używaj scrolla, aż zostanie -1.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-1]),
        miniQuest: _taskC2)
  ],
);

var _taskC2 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);
