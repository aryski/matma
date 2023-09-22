import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/update_handler.dart';
import 'package:matma/board_simulation/cubit/equation_board_cubit.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:meta/meta.dart';

part 'equation_board_event.dart';
part 'equation_board_state.dart';

class EquationBoardBloc extends Bloc<EquationBoardEvent, EquationBoardState> {
  final EquationBoardState init;
  final SimulationSize simSize;
  EquationBoardBloc(
      {required this.init,
      required this.simSize,
      required List<int> initNumbers})
      : super(UpdateHandler.hardResetState(initNumbers, simSize)) {
    on<EquationBoardEventUpdate>((event, emit) async {
      print(event.updatedNumbers);
      await handleUpdate(event.updatedNumbers, emit);
    });
  }
}

extension ItemsGenerator on EquationBoardBloc {
  NumberState generateNumberState(int number, Offset position) {
    assert(number >= 0);
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

  SignState generateSignState(Signs sign, Offset position) {
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
}
