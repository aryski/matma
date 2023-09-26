import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/items_generator.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

extension ValueUpdater on EquationBoardBloc {
  // Future<void> updateValue(SimulationItemCubit cubit, int value) {
  //   if (cubit is NumberCubit) {
  //     cubit.updateValue(value);
  //   }
  // }
}
