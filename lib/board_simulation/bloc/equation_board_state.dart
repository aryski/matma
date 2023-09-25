part of 'equation_board_bloc.dart';

class EquationBoardState {
  final List<SimulationItemCubit> items;

  EquationBoardState({this.items = const []});

  List<int> get numbers => genNum();

  List<int> genNum() {
    List<int> result = [];
    bool isMinus = false;
    for (var cubit in items) {
      if (cubit is SignCubit && cubit.state.value == Signs.substraction) {
        isMinus = true;
      }
      if (cubit is NumberCubit) {
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
