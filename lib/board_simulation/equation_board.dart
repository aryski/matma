import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/cubit/equation_board_cubit.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/number/presentation/number.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/board_simulation/items/sign/presentation/sign.dart';

class EquationBoard extends StatelessWidget {
  const EquationBoard({super.key, required this.unit});
  final double unit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquationBoardBloc, EquationBoardState>(
        builder: (context, state) {
      return Stack(children: [
        ...state.items.map((cubit) {
          if (cubit is NumberCubit) {
            return Number(cubit: cubit, key: cubit.state.id);
          } else if (cubit is SignCubit) {
            return Sign(cubit: cubit, key: cubit.state.id);
          } else {
            return const SizedBox.shrink();
          }
        }),
      ]);
    });
  }
}
