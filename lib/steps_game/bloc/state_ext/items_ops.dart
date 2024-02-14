part of 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension ItemsOps on StepsGameState {
  bool isLastItem(GameItemCubit item) {
    return numbers.last.steps.last.floor == item;
  }

  int? getNumberIndexFromItem(GameItemCubit item) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].filling == item) {
        return i;
      }
      if (numbers[i]
          .steps
          .where((element) => element.arrow == item || element.floor == item)
          .toList()
          .isNotEmpty) {
        return i;
      }
    }
    return null;
  }

  StepsGameNumberState? getNumberFromItem(GameItemCubit item) {
    var ind = getNumberIndexFromItem(item);
    if (ind != null) {
      return numbers[ind];
    }
    return null;
  }

  StepsGameStep? getStep(GameItemCubit item) {
    for (var number in numbers) {
      for (var step in number.steps) {
        if (item == step.arrow || item == step.floor) {
          return step;
        }
      }
    }
    return null;
  }
}
