part of 'steps_simulation_bloc.dart';

class StepsSimulationNumberState {
  List<SimulationItemCubit> items;
  StepsSimulationNumberState(this.items);

  int get number {
    int value = 0;
    for (var item in items) {
      if (item is ArrowCubit) {
        if (item.state.direction == Direction.up) {
          value++;
        } else if (item.state.direction == Direction.down) {
          value--;
        }
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

  void removeItem(SimulationItemCubit item) {
    for (var number in numbers) {
      if (number.items.contains(item)) {
        number.items.remove(item);
        if (number.items.isEmpty) {
          numbers.remove(number);
        }
        break;
      }
    }
  }

  int? minimumLevelSince(SimulationItemCubit item) {
    bool result = false;
    int value = 0;
    int minimum = 0;
    for (var number in numbers) {
      if (number.items.contains(item)) {
        //tutaj podlicz do tego
        for (int i = 0; i < number.items.length; i++) {
          var cubit = number.items[i];
          if (cubit is ArrowCubit) {
            if (cubit.state.direction == Direction.up) {
              value++;
              if (value < minimum) {
                minimum = value;
              }
              print("val: $value");
            } else if (cubit.state.direction == Direction.down) {
              value--;
              if (value < minimum) {
                minimum = value;
              }
              print("val: $value");
            }
          }
          if (cubit == item) {
            result = true;
            minimum = value;
          }
        }
      } else {
        value += number.number;
        if (value < minimum) {
          minimum = value;
        }
        print("val: $value");
      }
    }
    if (result) {
      return minimum;
    }
  }

  int? maxiumumLevelSince(SimulationItemCubit item) {
    bool result = false;
    int value = 0;
    int maximum = 0;
    for (var number in numbers) {
      if (number.items.contains(item)) {
        //tutaj podlicz do tego
        for (int i = 0; i < number.items.length; i++) {
          var cubit = number.items[i];
          if (cubit is ArrowCubit) {
            if (cubit.state.direction == Direction.up) {
              value++;
              if (value > maximum) {
                maximum = value;
              }
              print("val: $value");
            } else if (cubit.state.direction == Direction.down) {
              value--;
              if (value > maximum) {
                maximum = value;
              }
              print("val: $value");
            }
          }
          if (cubit == item) {
            result = true;
            maximum = value;
          }
        }
      } else {
        value += number.number;
        if (value > maximum) {
          maximum = value;
        }
        print("val: $value");
      }
    }
    if (result) {
      return maximum;
    }
  }

  //jakie jest minimum maximum OD tego itemka?
  int? levelOfSimulationItemCubit(SimulationItemCubit item) {
    int value = 0;
    print("val: $value");
    for (var number in numbers) {
      if (number.items.contains(item)) {
        //tutaj podlicz do tego
        for (int i = 0; i < number.items.length; i++) {
          var cubit = number.items[i];
          if (cubit is ArrowCubit) {
            if (cubit.state.direction == Direction.up) {
              value++;
              print("val: $value");
            } else if (cubit.state.direction == Direction.down) {
              value--;
              print("val: $value");
            }
          }
          if (cubit == item) {
            return value;
          }
        }
      } else {
        value += number.number;
        print("val: $value");
      }
    }
  }

  SimulationItemCubit? leftItem(SimulationItemCubit item) {
    SimulationItemCubit? lastItem;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].items.length; j++) {
        if (numbers[i].items[j] == item) {
          return lastItem;
        }
        lastItem = numbers[i].items[j];
      }
    }
    return null;
  }

  SimulationItemCubit? rightItem(SimulationItemCubit item) {
    bool next = false;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = 0; j < numbers[i].items.length; j++) {
        if (next) {
          return numbers[i].items[j];
        }
        if (numbers[i].items[j] == item) {
          next = true;
        }
      }
    }
    return null;
  }

  void _moveAllSince(SimulationItemCubit item, Offset offset, int indOffset) {
    bool move = false;
    for (var number in numbers) {
      if (move) {
        for (var cubit in number.items) {
          cubit.updatePosition(offset);
        }
      }
      if (number.items.contains(item)) {
        var ind = number.items.indexOf(item);
        for (int i = ind + indOffset; i < number.items.length; i++) {
          SimulationItemCubit cubit = number.items[i];
          cubit.updatePosition(offset);
        }
        move = true;
      }
    }
  }

  // StepsSimulationNumberState? getNumber(SimulationItemCubit item) {
  //   for (var number in numbers) {
  //     if (number.items.contains(item)) {
  //       return number;
  //     }
  //   }
  //   return null;
  // }

  int? getNumberIndex(SimulationItemCubit item) {
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].items.contains(item)) {
        return i;
      }
    }
    return null;
  }

  void moveAllSince(SimulationItemCubit item, Offset offset) {
    _moveAllSince(item, offset, 1);
  }

  void moveAllSinceIncluded(SimulationItemCubit item, Offset offset) {
    _moveAllSince(item, offset, 0);
  }

  StepsSimulationState copy() {
    return StepsSimulationState(
        simSize: simSize,
        numbers: [...numbers],
        unorderedItems: {...unorderedItems});
  }

  SimulationItemCubit? getItem(UniqueKey id) {
    for (var number in numbers) {
      for (var item in number.items) {
        if (item.state.id == id) {
          return item;
        }
      }
    }
    return null;
  }

  // int getIndex(UniqueKey id) {
  //   return numbers.indexWhere((element) => element.state.id == id);
  // }
}
