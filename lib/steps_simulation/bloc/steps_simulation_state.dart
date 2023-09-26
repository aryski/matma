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

  StepsSimulationState({required this.simSize, required this.numbers});

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
    return StepsSimulationState(simSize: simSize, numbers: [...numbers]);
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
