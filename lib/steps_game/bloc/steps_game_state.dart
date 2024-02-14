part of 'steps_game_bloc.dart';

class StepsGameStep {
  final ArrowCubit arrow;
  final FloorCubit floor;

  StepsGameStep({required this.arrow, required this.floor});
}

class StepsGameNumberState {
  List<StepsGameStep> steps;
  FillingCubit? filling;

  StepsGameNumberState({required this.steps, this.filling});

  int get number {
    int value = 0;
    for (var step in steps) {
      if (step.arrow.state.direction == Direction.up) {
        value++;
      } else if (step.arrow.state.direction == Direction.down) {
        value--;
      }
    }
    return value;
  }

  void setFilling(FillingCubit filling) {
    this.filling = filling;
  }
}

class StepsGameState {
  final List<StepsGameNumberState> numbers;
  final Map<UniqueKey, GameItemCubit> unorderedItems;

  bool showFilling;

  StepsGameState(
      {required this.showFilling,
      required this.numbers,
      required this.unorderedItems});

  GameItemCubit? getItem(UniqueKey id) {
    for (var number in numbers) {
      for (var step in number.steps) {
        if (step.arrow.state.id == id) {
          return step.arrow;
        } else if (step.floor.state.id == id) {
          return step.floor;
        }
      }
      if (number.filling != null && number.filling!.state.id == id) {
        return number.filling;
      }
    }
    return null;
  }

  StepsGameNumberState? getNumberToTheRight(StepsGameNumberState? number) {
    if (number != null) {
      for (int i = 0; i < numbers.length; i++) {
        if (numbers[i] == number) {
          if (i + 1 < numbers.length) {
            return numbers[i + 1];
          }
        }
      }
    }
    return null;
  }

  StepsGameState copy() {
    return StepsGameState(
        showFilling: showFilling,
        numbers: [...numbers],
        unorderedItems: {...unorderedItems});
  }
}
