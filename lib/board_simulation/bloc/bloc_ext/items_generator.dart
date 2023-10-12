import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/board_simulation/items/board/cubit/board_cubit.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension BoardItemsGenerator on EquationBoardBloc {
  static BoardState generateBoardState(
      {required Offset position, required Offset size}) {
    return BoardState(
        defColor: defaultEquator,
        hovColor: defaultEquator,
        id: UniqueKey(),
        position: position,
        size: size,
        color: defaultEquator,
        opacity: 1.0,
        radius: 20.0);
  }

  static NumberState generateNumberState(
      {required int number,
      required Offset position,
      double? opacity,
      required SimulationSize simSize}) {
    return NumberState(
        value: number.abs(),
        color: number > 0 ? defaultGreen : defaultRed,
        defColor: defaultYellow,
        hovColor: defaultYellow,
        id: UniqueKey(),
        position: position,
        size: number.abs() >= 10
            ? Offset(simSize.wRatio * 4, simSize.hRatio * 2)
            : Offset(simSize.wRatio * 2, simSize.hRatio * 2),
        opacity: opacity ?? 1,
        radius: 5,
        textKey: UniqueKey());
  }

  static SignState generateSignState(
      {required Signs sign,
      required Offset position,
      double? opacity,
      required SimulationSize simSize}) {
    return SignState(
      value: sign,
      color: Colors.white,
      defColor: defaultYellow,
      hovColor: defaultYellow,
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wRatio * 1.5, simSize.hRatio * 2),
      opacity: opacity ?? 1,
      radius: 5,
    );
  }

  static ShadowNumberState generateShadowNumberState(
      String value, Offset position, SimulationSize simSize) {
    return ShadowNumberState(
      value: value,
      color: defaultGrey,
      defColor: defaultGrey,
      hovColor: defaultGrey,
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wRatio * 2, simSize.hRatio * 2),
      opacity: 1,
      radius: 5,
    );
  }
}
