part of 'equation_board_bloc.dart';

class EquationBoardState {
  final List<SimulationItemCubit> items;
  final List<SimulationItemCubit> extraItems;

  EquationBoardState({this.items = const [], this.extraItems = const []});

  List<int> get numbers => genNum();

  Signs getNumberSign(NumberCubit number) {
    bool foundNumber = false;

    for (int i = items.length - 1; i >= 0; i--) {
      if (foundNumber) {
        var cubit = items[i];
        if (cubit is SignCubit) {
          if (cubit.state.value == Signs.substraction) {
            return Signs.substraction;
          } else {
            return Signs.addition;
          }
        }
      }
      if (items[i] == number) {
        foundNumber = true;
      }
    }
    return Signs.addition;
  }

  List<int> genNum() {
    List<int> result = [];
    bool isMinus = false;
    print(items);
    for (var cubit in items) {
      if (cubit is SignCubit && cubit.state.value == Signs.substraction) {
        isMinus = true;
      }
      if (cubit is NumberCubit) {
        print(cubit.state.value);
        if (isMinus) {
          result.add(-1 * cubit.state.value);
        } else {
          result.add(cubit.state.value);
        }
        isMinus = false;
      }
    }
    print(result);
    return result;
  }

  int? itemIndex(int numberIndex) {
    var result = 0;

    for (int i = 0; i < items.length; i++) {
      if (items[i] is NumberCubit) {
        if (result == numberIndex) {
          return i;
        }
        result += 1;
      }
    }
    return null;
  }
}
