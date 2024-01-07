part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension StepsOps on StepsGameState {
  bool isFirstStep(StepsGameStep step) {
    return numbers.first.steps.first == step;
  }

  int? getNumberIndexFromStep(StepsGameStep step) {
    return getNumberIndexFromItem(step.arrow);
  }

  void removeStep(StepsGameStep step) {
    for (var number in numbers) {
      if (number.steps.contains(step)) {
        number.steps.remove(step);
        if (number.steps.isEmpty) {
          numbers.remove(number);
        }
        break;
      }
    }
  }

  void replaceStep(StepsGameStep step, StepsGameStep replacement) {
    for (var number in numbers) {
      for (int i = 0; i < number.steps.length; i++) {
        if (number.steps[i] == step) {
          number.steps[i] = replacement;
          return;
        }
      }
    }
  }

  void insertStepAt(StepsGameStep step, StepsGameStep inserted) {
    for (var number in numbers) {
      for (int i = 0; i < number.steps.length; i++) {
        if (number.steps[i] == step) {
          number.steps.insert(i, inserted);
          return;
        }
      }
    }
  }

  StepsGameStep? leftStep(StepsGameStep step) {
    StepsGameStep? lastItem;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].steps.length; j++) {
        if (numbers[i].steps[j] == step) {
          return lastItem;
        }
        lastItem = numbers[i].steps[j];
      }
    }
    return null;
  }

  StepsGameStep? rightStep(StepsGameStep step) {
    bool next = false;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].steps.length; j++) {
        if (next) {
          return numbers[i].steps[j];
        }
        if (numbers[i].steps[j] == step) {
          next = true;
        }
      }
    }
    return null;
  }
}
