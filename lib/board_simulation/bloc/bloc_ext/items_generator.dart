import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

extension BoardItemsGenerator on EquationBoardBloc {
  static NumberState generateNumberState(
      int number, Offset position, SimulationSize simSize) {
    return NumberState(
        value: number.abs(),
        color: number > 0 ? defaultGreen : defaultRed,
        defColor: defaultYellow,
        hovColor: defaultYellow,
        id: UniqueKey(),
        position: position,
        size: number.abs() >= 10
            ? Offset(simSize.wUnit * 4, simSize.hUnit * 2)
            : Offset(simSize.wUnit * 2, simSize.hUnit * 2),
        opacity: 1,
        radius: 5,
        textKey: UniqueKey());
  }

  static SignState generateSignState(
      Signs sign, Offset position, SimulationSize simSize) {
    return SignState(
        value: sign,
        color: Colors.white,
        defColor: defaultYellow,
        hovColor: defaultYellow,
        id: UniqueKey(),
        position: position,
        size: Offset(simSize.wUnit * 1.5, simSize.hUnit * 2),
        opacity: 1,
        radius: 5);
  }
}
