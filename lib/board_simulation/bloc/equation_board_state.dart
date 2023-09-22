part of 'equation_board_bloc.dart';

class EquationBoardState {
  final List<SimulationItemCubit> numCubits;

  EquationBoardState({this.numCubits = const []});

  List<int> get numbers => genNum();

  List<int> genNum() {
    List<int> result = [];
    bool isMinus = false;
    for (var cubit in numCubits) {
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

  int? cubitIndex(int numberIndex) {
    var result = 0;

    for (int i = 0; i < numCubits.length; i++) {
      if (numCubits[i] is NumberCubit) {
        if (result == numberIndex) {
          return i;
        }
        result += 1;
      }
    }
    return null;
  }
}
