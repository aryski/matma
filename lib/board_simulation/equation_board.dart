import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/board/cubit/board_cubit.dart';
import 'package:matma/board_simulation/items/board/presentation/board.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/number/presentation/number.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/presentation/shadow_number.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/board_simulation/items/sign/presentation/sign.dart';

class EquationBoard extends StatelessWidget {
  const EquationBoard({super.key, required this.unit});
  final double unit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquationBoardBloc, EquationBoardState>(
        builder: (context, state) {
      //TODO moze warto by zrobic tak ze jak cos znika z listy to nie znaczy ze znika z outputu???
      //zwlaszcza, ale sam sobie jestem winien w sumie przez to ze stany wygladaja jak wygladaja
      //moznaby zrobic osobna liste z niedawno usunietymi ktora tez renderujemy w stacku!!!
      //zeby mogla dogorzec koncowka animacji czy cos xddd
      return Stack(children: [
        ...state.extraItems.map((cubit) {
          if (cubit is BoardCubit) {
            return Board(cubit: cubit);
          } else {
            return const SizedBox.shrink();
          }
        }),
        ...state.items.map((cubit) {
          if (cubit is NumberCubit) {
            return Number(cubit: cubit, key: cubit.state.id);
          } else if (cubit is SignCubit) {
            return Sign(cubit: cubit, key: cubit.state.id);
          } else {
            return const SizedBox.shrink();
          }
        }),
        ...state.extraItems.map((cubit) {
          if (cubit is ShadowNumberCubit) {
            return ShadowNumber(cubit: cubit, key: cubit.state.id);
          } else if (cubit is NumberCubit) {
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
