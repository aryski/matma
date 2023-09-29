part of 'steps_simulation_bloc.dart';

class StepsSimulationDefaultItem {
  final ArrowCubit arrow;
  final FloorCubit floor;

  StepsSimulationDefaultItem({required this.arrow, required this.floor});
}

class StepsSimulationNumberState {
  List<StepsSimulationDefaultItem> steps;
  StepsSimulationNumberState(this.steps);

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

class StepsSimulationState {
  final SimulationSize simSize;
  final List<StepsSimulationNumberState> numbers;
  Map<UniqueKey, SimulationItemCubit> unorderedItems;

  StepsSimulationState(
      {required this.simSize,
      required this.numbers,
      required this.unorderedItems});

  void removeStep(StepsSimulationDefaultItem step) {
    for (var number in numbers) {
      number.steps.remove(step);
    }
  }

  int? minmaxLevelSince(SimulationItemCubit item, bool max) {
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
        print("MAX: $maximum");
        return maximum;
      } else {
        print("MIN: $minimum");
        return minimum;
      }
    }
    return null;
  }

  void replaceStep(
      StepsSimulationDefaultItem step, StepsSimulationDefaultItem replacement) {
    for (var number in numbers) {
      for (int i = 0; i < number.steps.length; i++) {
        if (number.steps[i] == step) {
          print("XDONE");
          number.steps[i] = replacement;
          return;
        }
      }
    }
  }

  StepsSimulationDefaultItem? getStep(SimulationItemCubit item) {
    for (var number in numbers) {
      for (var step in number.steps) {
        if (item == step.arrow || item == step.floor) {
          return step;
        }
      }
    }
    return null;
  }

  int? minimumLevelSince(SimulationItemCubit item) {
    return minmaxLevelSince(item, false);
  }

  int? maxiumumLevelSince(SimulationItemCubit item) {
    return minmaxLevelSince(item, true);
  }

  // StepsSimulationDefaultItem? leftItem(SimulationItemCubit item) {
  //   StepsSimulationDefaultItem? lastItem;
  //   for (int i = 0; i < numbers.length; i++) {
  //     for (int j = 0; j < numbers[i].steps.length; j++) {
  //       if (numbers[i].steps[j] == item) {
  //         return lastItem;
  //       }
  //       lastItem = numbers[i].steps[j];
  //     }
  //   }
  //   return null;
  // }

  // StepsSimulationDefaultItem? rightItem(SimulationItemCubit item) {
  //   bool next = false;
  //   for (int i = 0; i < numbers.length; i++) {
  //     for (int j = 0; j < numbers[i].steps.length; j++) {
  //       if (next) {
  //         return numbers[i].steps[j];
  //       }
  //       if (numbers[i].steps[j] == item) {
  //         next = true;
  //       }
  //     }
  //   }
  //   return null;
  // }

  StepsSimulationDefaultItem? leftStep(StepsSimulationDefaultItem item) {
    StepsSimulationDefaultItem? lastItem;
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

  StepsSimulationDefaultItem? rightStep(StepsSimulationDefaultItem item) {
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

  void _moveAllSince(SimulationItemCubit item, Offset offset, bool included) {
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

  int? getNumberIndex(StepsSimulationDefaultItem item) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].steps.contains(item)) {
        return i;
      }
    }
    return null;
  }

  void moveAllSince(SimulationItemCubit item, Offset offset) {
    _moveAllSince(item, offset, false);
  }

  void moveAllSinceIncluded(SimulationItemCubit item, Offset offset) {
    _moveAllSince(item, offset, true);
  }

  StepsSimulationState copy() {
    return StepsSimulationState(
        simSize: simSize,
        numbers: [...numbers],
        unorderedItems: {...unorderedItems});
  }

  SimulationItemCubit? getItem(UniqueKey id) {
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
