import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/resizer.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';

extension UpdateHandler on EquationBoardBloc {
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

  void updateCubitValueByForce(int cubitInd, int value) {
    if (cubitInd < state.numCubits.length &&
        state.numCubits[cubitInd] is NumberCubit) {
      var cubit = (state.numCubits[cubitInd] as NumberCubit);
      var oldValue = cubit.state.value.abs();
      cubit.updateValue(value); //updated value
      //resizing for bigger numbers
      if (cubit.state.value.abs() == 10 && oldValue == 9) {
        //TODO two digits one digit
        resize(cubitInd, simSize.wUnit * 2);
      } else if (cubit.state.value.abs() == 9 && oldValue == 10) {
        resize(cubitInd, -simSize.wUnit * 2);
      }
    }
  }

  bool tryUpdatingOneDigit(List<int> updatedNumbers) {
    print("one dig");

    //increase of one number scenario
    var currentNumbers = state.numbers;
    int? ind;
    List<int> indexes = [];
    if (updatedNumbers.length == currentNumbers.length) {
      for (int i = 0; i < currentNumbers.length; i++) {
        if (currentNumbers[i] != updatedNumbers[i]) {
          indexes.add(i);
        }
      }
      if (indexes.length == 1) {
        ind = indexes.first; //only different index
      }
    }
    if (ind == null) return false;
    int? cubitInd = state.cubitIndex(ind);
    if (cubitInd == null) return false;
    updateCubitValueByForce(cubitInd, updatedNumbers[ind].abs());
    return true;
  }

  bool tryUpdatingFullMerge(List<int> updatedNumbers) {
    List<int> differentIndexes = [];
    var currentNumbers = state.numbers;
    if (currentNumbers.length == updatedNumbers.length) {
      for (int i = 0; i < currentNumbers.length; i++) {
        if (currentNumbers[i] != updatedNumbers[i]) {
          differentIndexes.add(i);
        }
      }
    }
    if (differentIndexes.length != 2) return false;
    //two neighboring elements are updated
    var left = differentIndexes[0];
    var right = differentIndexes[1];
    if (right - left != 1) return false; //are not neighboring

    //neighboring indexes
    //albo lewy sie zwiekszyl a prawy zmniejszyl albo na odwrot
    int? cubitIndLeft = state.cubitIndex(left);
    int? cubitIndRight = state.cubitIndex(left);
    if (cubitIndLeft == null || cubitIndRight == null) return false;
    print("XD");
    print(currentNumbers);
    print(updatedNumbers);

    print(updatedNumbers[left] - currentNumbers[left]);
    print(updatedNumbers[right] - currentNumbers[right]);
    if (updatedNumbers[left] - currentNumbers[left] == 1 &&
        updatedNumbers[right] - currentNumbers[right] == -1) {
      //lewy increase by 1 prawy decrease by 1
      //update values for both of them
      // success = true;

      updateCubitValueByForce(cubitIndLeft, updatedNumbers[left]);
      updateCubitValueByForce(cubitIndRight, updatedNumbers[left]);
      return true;
    } else if (updatedNumbers[left] - currentNumbers[left] == -1 &&
        updatedNumbers[right] - currentNumbers[right] == 1) {
      //lewy decrease prawy increase
      //update values for both of them

      updateCubitValueByForce(cubitIndLeft, updatedNumbers[left]);
      updateCubitValueByForce(cubitIndRight, updatedNumbers[left]);
      return true;
    }
    //dwa kolejne indeksy po sobie rozne wiec jest duza szansa na ten wariant
    //albo 2-2 -> 1-1 albo -2+ 2 przeszlo w -1 + 1
    return false;
  }

  Future<void> handleUpdate(
      //jak leci merge to decrease i particlesy fadujace w dol z -1 i +1 oraz jedna liczba moze zamienic sie na 0 i potem faduje
      List<int> updatedNumbers,
      Emitter<EquationBoardState> emit) async {
    bool success = false;
    if (!listEquals(updatedNumbers, state.numbers)) {
      if (!tryUpdatingOneDigit(updatedNumbers)) {
        if (!tryUpdatingFullMerge(updatedNumbers)) {
          //pozostaje jeszcze merge jak jedno znika
          //i jeszcze merge jak oba znikaja XD
          //TODO TASK
          emit(hardResetState(updatedNumbers, simSize));
        }
      }
    }
  }

  static EquationBoardState hardResetState(
      List<int> updatedNumbers, SimulationSize simSize) {
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
        signState = BoardItemsGenerator.generateSignState(
            Signs.addition, Offset(length, top), simSize);
      } else if (number < 0) {
        signState = BoardItemsGenerator.generateSignState(
            Signs.substraction, Offset(length, top), simSize);
      }
      if (signState != null) {
        states.add(signState);
        length += signState.size.dx;
      }

      var numberState = BoardItemsGenerator.generateNumberState(
          number, Offset(length, top), simSize);
      states.add(numberState);
      length += numberState.size.dx;
    }
    var allMargin = (widthSpace - length) / 2;
    for (var state in states) {
      state.position += Offset(allMargin, 0);
      if (state is SignState) {
        numCubits.add(SignCubit(state));
      } else if (state is NumberState) {
        numCubits.add(NumberCubit(state));
      }
    }
    return EquationBoardState(numCubits: numCubits);
  }
}
