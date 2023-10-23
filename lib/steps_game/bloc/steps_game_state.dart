part of 'steps_game_bloc.dart';

class StepsGameDefaultItem {
  final ArrowCubit arrow;
  final FloorCubit floor;

  StepsGameDefaultItem({required this.arrow, required this.floor});
}

class StepsGameNumberState {
  List<StepsGameDefaultItem> steps;
  StepsGameNumberState(this.steps);

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
}

class StepsGameState {
  final SimulationSize simSize;
  final List<StepsGameNumberState> numbers;
  Map<UniqueKey, GameItemCubit> unorderedItems;

  StepsGameState(
      {required this.simSize,
      required this.numbers,
      required this.unorderedItems});

  void removeStep(StepsGameDefaultItem step) {
    for (var number in numbers) {
      if (number.steps.contains(step)) {
        print("contains ${step.floor.state.id}");
        // unorderedItems[step.floor.state.id] = step.floor;
        number.steps.remove(step);
        if (number.steps.isEmpty) {
          numbers.remove(number);
        }
      }
    }
  }

  int? minmaxLevelSince(GameItemCubit item, bool max) {
    var myStep = getStep(item);
    if (myStep == null) {
      return null;
    }
    bool result = false;
    int value = 0;
    int maximum = 0;
    int minimum = 0;
    for (var number in numbers) {
      if (number.steps.contains(myStep)) {
        for (var step in number.steps) {
          var dir = step.arrow.state.direction;
          if (dir == Direction.up) {
            value++;
          } else if (dir == Direction.down) {
            value--;
          }
          if (dir == Direction.up || dir == Direction.down) {
            if (value > maximum) {
              maximum = value;
            }
            if (value < minimum) {
              minimum = value;
            }
          }

          if (myStep == step) {
            result = true;
            maximum = value;
            minimum = value;
          }
        }
      } else {
        value += number.number;
        if (value > maximum) {
          maximum = value;
        }
        if (value < minimum) {
          minimum = value;
        }
      }
    }
    if (result) {
      if (max) {
        return maximum;
      } else {
        return minimum;
      }
    }
    return null;
  }

  void replaceStep(
      StepsGameDefaultItem step, StepsGameDefaultItem replacement) {
    for (var number in numbers) {
      for (int i = 0; i < number.steps.length; i++) {
        if (number.steps[i] == step) {
          number.steps[i] = replacement;
          return;
        }
      }
    }
  }

  StepsGameDefaultItem? getStep(GameItemCubit item) {
    for (var number in numbers) {
      for (var step in number.steps) {
        if (item == step.arrow || item == step.floor) {
          return step;
        }
      }
    }
    return null;
  }

  int? minimumLevelSince(GameItemCubit item) {
    return minmaxLevelSince(item, false);
  }

  int? maxiumumLevelSince(GameItemCubit item) {
    return minmaxLevelSince(item, true);
  }

  StepsGameDefaultItem? leftStep(StepsGameDefaultItem item) {
    StepsGameDefaultItem? lastItem;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].steps.length; j++) {
        if (numbers[i].steps[j] == item) {
          return lastItem;
        }
        lastItem = numbers[i].steps[j];
      }
    }
    return null;
  }

  StepsGameDefaultItem? rightStep(StepsGameDefaultItem item) {
    bool next = false;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].steps.length; j++) {
        if (next) {
          return numbers[i].steps[j];
        }
        if (numbers[i].steps[j] == item) {
          next = true;
        }
      }
    }
    return null;
  }

  void _moveAllSince(GameItemCubit item, Offset offset, bool included) {
    bool update = false;
    for (var number in numbers) {
      for (var step in number.steps) {
        if (update) {
          step.arrow.updatePosition(offset);
          step.floor.updatePosition(offset);
        }

        if (step.arrow == item || step.floor == item) {
          if (step.arrow == item && included) {
            step.arrow.updatePosition(offset);
          }
          if ((step.arrow == item && !included) || included) {
            step.floor.updatePosition(offset);
          }
          update = true;
        }
      }
    }
  }

  int? getNumberIndex(StepsGameDefaultItem item) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].steps.contains(item)) {
        return i;
      }
    }
    return null;
  }

  bool isFirstStep(StepsGameDefaultItem step) {
    return numbers.first.steps.first == step;
  }

  bool isLastItem(GameItemCubit item) {
    //steps might be empty!!!!
    return numbers.last.steps.last.floor == item;
  }

  void moveAllSince(GameItemCubit item, Offset offset) {
    _moveAllSince(item, offset, false);
  }

  void moveAllSinceIncluded(GameItemCubit item, Offset offset) {
    _moveAllSince(item, offset, true);
  }

  StepsGameState copy() {
    return StepsGameState(
        simSize: simSize,
        numbers: [...numbers],
        unorderedItems: {...unorderedItems});
  }

  GameItemCubit? getItem(UniqueKey id) {
    for (var number in numbers) {
      for (var step in number.steps) {
        if (step.arrow.state.id == id) {
          return step.arrow;
        } else if (step.floor.state.id == id) {
          return step.floor;
        }
      }
    }
    return null;
  }
}
