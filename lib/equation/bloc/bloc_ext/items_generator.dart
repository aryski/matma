import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/equation_bloc.dart';
import 'package:matma/equation/items/board/cubit/board_cubit.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

extension BoardItemsGenerator on EquationBloc {
  static BoardState generateBoardState(
      {required Offset position, required Offset size}) {
    return BoardState(
        id: UniqueKey(),
        position: position,
        size: size,
        opacity: 1.0,
        radius: 20.0);
  }

  static NumberState generateNumberState(
      {required int number,
      required Offset position,
      double? opacity,
      required SimulationSize simSize,
      bool? isInactive,
      bool withDarkenedColor = false}) {
    return NumberState(
      withDarkenedColor: withDarkenedColor,
      value: number.abs(),
      sign: ((number > 0) ? Signs.addition : Signs.substraction),
      id: UniqueKey(),
      position: position,
      size: number.abs() >= 10
          ? Offset(simSize.wRatio * 4, simSize.hRatio * 2)
          : Offset(simSize.wRatio * 2, simSize.hRatio * 2),
      opacity: opacity ?? 1,
      radius: 5,
      textKey: UniqueKey(),
    );
  }

  static SignState generateSignState(
      {required Signs sign,
      required Offset position,
      double? opacity,
      required SimulationSize simSize}) {
    return SignState(
      value: sign,
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
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wRatio * 2, simSize.hRatio * 2),
      opacity: 1,
      radius: 5,
    );
  }
}
