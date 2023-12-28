import 'package:flutter/material.dart';
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/levels/level/level.dart';
import 'package:matma/levels/levels/level7.dart';
import 'package:matma/quest/bloc/quests_bloc.dart';

import 'package:matma/quest/items/mini_quest.dart';

// Level 6
// Reducing numbers.

Level getLevel6() {
  return Level(
    next: getLevel7(),
    data: LevelData(
      icon: Icons.reduce_capacity_rounded,
      ind: 6,
      name: 'Poziom 6',
      gamesData: [
        StepsGameData(
          allowedOps: [StepsGameOps.splitJoinArrows, StepsGameOps.reduceArrows],
          initNumbers: [2, -1],
          firstTask: _taskA1,
        ),
        StepsGameData(
          allowedOps: [StepsGameOps.splitJoinArrows, StepsGameOps.reduceArrows],
          initNumbers: [4, -3],
          firstTask: _taskB1,
        ),
        StepsGameData(
          allowedOps: [StepsGameOps.splitJoinArrows, StepsGameOps.reduceArrows],
          initNumbers: [-4, 3],
          firstTask: _taskC1,
        ),
        StepsGameData(allowedOps: [
          StepsGameOps.splitJoinArrows,
          StepsGameOps.reduceArrows
        ], initNumbers: [
          1,
          5,
          -5,
          1,
          -6,
          6,
          -3
        ], firstTask: _taskD1),
      ],
    ),
  );
}

var _taskA1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Wiesz, że 1-1 = 0?', seconds: 1.5),
    NextPrompt(text: 'Wykorzystamy to teraz.', seconds: 1.5),
    NextPrompt(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 3),
    NextPrompt(text: 'Ma powstać 1', seconds: 5),
    NextPrompt(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1]),
        miniQuest: _taskA2)
  ],
);

var _taskA2 = MiniQuest(prompts: [
  NextPrompt(text: 'Git.', seconds: 1.5),
  EndPrompt(),
], choices: []);

var _taskB1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'Teraz zrobimy to samo kilka razy.', seconds: 2),
    NextPrompt(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 3),
    NextPrompt(text: 'Aż zostanie sama 1.', seconds: 5),
    NextPrompt(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [1]),
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
    NextPrompt(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 1.5),
    NextPrompt(text: 'Aż zostanie samo -1.', seconds: 5),
    NextPrompt(text: 'Scrolluj w dół szare pomiędzy zielonym i czerwonym.'),
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

var _taskD1 = MiniQuest(
  prompts: [
    NextPrompt(text: 'No i zwijamy wszystko, aż zostanie -1', seconds: 1.5),
    NextPrompt(
        text: 'Scrolluj szare pomiędzy zielonym i czerwonym.', seconds: 1.5),
    NextPrompt(text: 'Ma zostać -1.', seconds: 5),
    NextPrompt(text: 'Scrolluj szare, w końcu się uda.'),
  ],
  choices: [
    Choice(
        trigEvent: TrigEventEquationValue(numbers: const [-1]),
        miniQuest: _taskD2)
  ],
);

var _taskD2 = MiniQuest(prompts: [
  NextPrompt(text: 'No i elegancko.', seconds: 2),
  EndPrompt(),
], choices: []);
