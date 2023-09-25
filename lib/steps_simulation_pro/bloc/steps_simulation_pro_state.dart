part of 'steps_simulation_pro_bloc.dart';

class StepsSimulationProNumberState {
  int number;
  List<SimulationItemCubit> items;
  StepsSimulationProNumberState(this.number, this.items);

  void expand() {
    if (number > 0) {
      number += 1;
    } else if (number < 0) {
      number -= 1;
    }
  }

  void reduce() {
    if (number > 0) {
      number -= 1;
    } else if (number < 0) {
      number += 1;
    }
  }
}

class StepsSimulationProState {
  final SimulationSize simSize;
  final List<StepsSimulationProNumberState> numbers;

  StepsSimulationProState({required this.simSize, required this.numbers});

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

  void expandItemNumber(SimulationItemCubit item) {
    for (var number in numbers) {
      if (number.items.contains(item)) {
        number.expand();
      }
    }
  }

  void reduceItemNumber(SimulationItemCubit item) {
    for (var number in numbers) {
      if (number.items.contains(item)) {
        number.reduce();
      }
    }
  }

  // StepsSimulationProNumberState? getNumber(SimulationItemCubit item) {
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

  StepsSimulationProState copy() {
    return StepsSimulationProState(simSize: simSize, numbers: [...numbers]);
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
