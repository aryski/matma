part of 'steps_game_bloc.dart';

class StepsGameDefaultItem {
  final ArrowCubit arrow;
  final FloorCubit floor;

  StepsGameDefaultItem({required this.arrow, required this.floor});
}

class StepsGameNumberState {
  List<StepsGameDefaultItem> steps;
  FillingCubit? filling;
  //get top width

  //

  //FillingCubit TODO add FIllingCubit here
  //we add FillingCubit that's "technically" placed after the floor
  //actually all we need from the following StepsGameDefItem is that,
  //the next NumberState has opposite number
  //fade right, fade left, for now add it with fade out and fade in
  //i tylko potrzebuję liczbę oraz długość ostatniego floora xd zeby to namalować w sumie xd

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
  Map<UniqueKey, GameItemCubit> unorderedItems;

  StepsGameState({required this.numbers, required this.unorderedItems});

  void removeStep(StepsGameDefaultItem step) {
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

  void insertStepAt(StepsGameDefaultItem step, StepsGameDefaultItem inserted) {
    for (var number in numbers) {
      for (int i = 0; i < number.steps.length; i++) {
        if (number.steps[i] == step) {
          number.steps.insert(i, inserted);
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

  int? getNumberIndexFromStep(StepsGameDefaultItem item) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].steps.contains(item)) {
        return i;
      }
    }
    return null;
  }

  int? getNumberIndexFromItem(GameItemCubit item) {
    for (int i = 0; i < numbers.length; i++) {
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
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i]
              .steps
              .where(
                  (element) => element.arrow == item || element.floor == item)
              .toList()
              .isNotEmpty ||
          numbers[i].filling != null && numbers[i].filling == item) {
        return numbers[i];
      }
    }
    return null;
  }

  bool isFirstStep(StepsGameDefaultItem step) {
    return numbers.first.steps.first == step;
  }

  bool isLastItem(GameItemCubit item) {
    return numbers.last.steps.last.floor == item;
  }

  // void ifFillingUpdateWdt(GameItemCubit item, double delta) {
  //   var ind = getNumberIndexFromItem(item);
  //   if (ind != null && numbers[ind].steps.last.floor == item) {
  //     numbers[ind].filling?.updateSize(Offset(delta, 0));
  //   }
  // }

  void updatePositionSince(
      {required GameItemCubit item,
      required Offset offset,
      bool fillingIncluded = true,
      required int milliseconds}) {
    bool update = false;
    for (var number in numbers) {
      if (!fillingIncluded) {
        if (update && number.filling != null) {
          number.filling?.updatePosition(offset, milliseconds: milliseconds);
        }
      }
      for (var step in number.steps) {
        if (update) {
          step.arrow.updatePosition(offset, milliseconds: milliseconds);
          step.floor.updatePosition(offset, milliseconds: milliseconds);
        }

        if (step.arrow == item || step.floor == item) {
          if ((step.arrow == item)) {
            step.floor.updatePosition(offset, milliseconds: milliseconds);
          }
          update = true;
        }
      }
      if (fillingIncluded && update && number.filling != null) {
        number.filling?.updatePosition(offset, milliseconds: milliseconds);
      }
    }
  }

  void updateStepHgt(
      {required ArrowCubit item,
      required double delta,
      required int milliseconds}) {
    item.updateHeight(delta, milliseconds);
    if (item.state.direction == Direction.up) {
      delta = -delta;
      item.updatePosition(Offset(0, delta), milliseconds: milliseconds);
    }
    updatePositionSince(
        item: item, offset: Offset(0, delta), milliseconds: milliseconds);
  }

  StepsGameState copy() {
    return StepsGameState(
        numbers: [...numbers], unorderedItems: {...unorderedItems});
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
      if (number.filling != null && number.filling!.state.id == id) {
        return number.filling;
      }
    }
    return null;
  }
}
