import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:meta/meta.dart';

part 'equation_board_state.dart';

class BoardSimulationCubit extends Cubit<BoardSimulationState> {
  final BoardSimulationState init;
  final SimulationSize simSize;
  BoardSimulationCubit({required this.init, required this.simSize})
      : super(init);

  void update(List<int> updatedNumbers) {
    print("update: $updatedNumbers");
    if (!listEquals(updatedNumbers, state.numbers)) {
      //scenariusze animujace:
      //rozdzielenie dwoch liczb
      //zlaczenie dwoch liczb
      //dodanie liczby
      //w pozostalym przypadku wykonac calkowity print nowych cyferek
      int? _elo = _isUpdateOfOneDigit(updatedNumbers);
      int? _insertionIndex = _isInsertion(updatedNumbers);

      if (_elo != null) {
        int j = 0;
        for (int i = 0; i < state.numCubits.length; i++) {
          if (state.numCubits[i] is NumberCubit) {
            if (j == _elo) {
              var cubit = (state.numCubits[i] as NumberCubit);
              var oldValue = cubit.state.value.abs();
              if (cubit.state.value > 0) {
                cubit.increase();
              } else {
                cubit.decrease();
              }
              if (cubit.state.value.abs() == 10 && oldValue == 9) {
                //resize widgets and move them
                //na lewo o wUnit i na prawo o wUnit wszystkie od tego cubita
                for (int j = 0; j <= i; j++) {
                  //te wszystkie o wUnit na lewo
                  state.numCubits[j].updatePosition(Offset(-simSize.wUnit, 0));
                }
                cubit.updateSize(Offset(2 * simSize.wUnit, 0));
                // cubit.updatePosition(Offset(-simSize.wUnit, 0));
                for (int j = i + 1; j < state.numCubits.length; j++) {
                  //te wszystkie o wUnit na prawo
                  state.numCubits[j].updatePosition(Offset(simSize.wUnit, 0));
                }
              } else if (oldValue == 10 && cubit.state.value.abs() == 9) {
                //decrrease non existent for now
                //resize widgets and move them
                //na lewo o wUnit i na prawo o wUnit wszystkie od tego cubita
                for (int j = 0; j <= i; j++) {
                  //te wszystkie o wUnit na lewo
                  state.numCubits[j].updatePosition(Offset(simSize.wUnit, 0));
                }
                cubit.updateSize(Offset(-2 * simSize.wUnit, 0));
                // cubit.resize();
                for (int j = i + 1; j < state.numCubits.length; j++) {
                  //te wszystkie o wUnit na prawo
                  state.numCubits[j].updatePosition(Offset(-simSize.wUnit, 0));
                }
              }
              break;
            }
            j++;
          }
        }
      } else if (_insertionIndex != null) {
        // int j = 0;
        // print("insetrtion");
        // for (int i = 0; i < state.numCubits.length; i++) {
        //   if (state.numCubits[i] is NumberCubit) {
        //     if (j == _insertionIndex) {
        //       //wtedy to jest to
        //       print("XD $j");
        //       (state.numCubits[i] as NumberCubit).increase();
        //       break;
        //     }
        //     j++;
        //   }
        // }

        // state.numCubits.insert(
        //     _insertionIndex,
        //     NumberCubit(_generateNumberState(
        //         updatedNumbers[_insertionIndex], Offset())));
      } else {
//animujemy nowe cyferki kompletnie
        var top = simSize.hUnit / 2;
        var widthSpace = simSize.wUnit * simSize.wUnits;
        //wiec od centrumr
        double length = 0;
        var signMargin = -0.0 * simSize.hUnit;
        var horizMargin = 0.0 * simSize.wUnit;
        List<SimulationItemCubit> numCubits = [];
        List<SimulationItemState> states = [];
        for (int i = 0; i < updatedNumbers.length; i++) {
          var number = updatedNumbers[i];
          SignState? signState;
          if (number > 0 && i != 0) {
            signState = _generateSignState(Signs.addition, Offset(length, top));
          } else if (number < 0) {
            signState =
                _generateSignState(Signs.substraction, Offset(length, top));
          }
          if (signState != null) {
            states.add(signState);
            length += signState.size.dx;
          }

          var numberState = _generateNumberState(number, Offset(length, top));
          states.add(numberState);
          length += numberState.size.dx;
        }
        var allMargin = (widthSpace - length) / 2;
        for (var state in states) {
          state.position += Offset(allMargin, 0);
          if (state is SignState) {
            numCubits.add(SignCubit(state));
          } else if (state is NumberState) {
            print(state.value);
            numCubits.add(NumberCubit(state));
          }
        }
        emit(BoardSimulationState(numCubits: numCubits));
      }
    }
  }

  NumberState _generateNumberState(int number, Offset position) {
    return NumberState(
        value: number,
        color: Color.fromARGB(255, 255, 217, 0),
        defColor: Color.fromARGB(255, 255, 217, 0),
        hovColor: Color.fromARGB(255, 255, 217, 0),
        id: UniqueKey(),
        position: position,
        size: number.abs() >= 10
            ? Offset(simSize.wUnit * 4, simSize.hUnit * 2)
            : Offset(simSize.wUnit * 2, simSize.hUnit * 2),
        opacity: 1,
        radius: 5);
  }

  SignState _generateSignState(Signs sign, Offset position) {
    return SignState(
        value: sign,
        color: Color.fromARGB(255, 255, 217, 0),
        defColor: Color.fromARGB(255, 255, 217, 0),
        hovColor: Color.fromARGB(255, 255, 217, 0),
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit * 1.5, simSize.hUnit * 2),
        opacity: 1,
        radius: 5);
  }

  //If updatedNumbers differs from numbers by one element, it returns its index.
  int? _isInsertion(List<int> updatedNumbers) {
    var currentNumbers = state.numbers;
    int lastInd = 0;
    if (updatedNumbers.length - currentNumbers.length == 1) {
      for (int i = 0; i < currentNumbers.length; i++) {
        if (currentNumbers[i] != updatedNumbers[i]) {
          lastInd = i;
          break; //TODO co jak nie znajdzie
        }
      }
      currentNumbers.insert(lastInd, updatedNumbers[lastInd]);
      if (listEquals(updatedNumbers, currentNumbers)) return lastInd;
    }
    return null;
  }

  int? _isUpdateOfOneDigit(List<int> updatedNumbers) {
    var currentNumbers = state.numbers;
    int? lastInd;
    int same = 0;
    if (updatedNumbers.length == currentNumbers.length) {
      for (int i = 0; i < currentNumbers.length; i++) {
        if (currentNumbers[i] != updatedNumbers[i]) {
          lastInd = i;
        } else {
          same++;
        }
      }
      if (same + 1 == updatedNumbers.length) {
        return lastInd;
      }
    }
    return null;
  }
}
