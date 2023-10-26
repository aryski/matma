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
      required GameSize gs,
      bool? isInactive,
      bool withDarkenedColor = false}) {
    return NumberState(
      withDarkenedColor: withDarkenedColor,
      value: number.abs(),
      sign: ((number > 0) ? Signs.addition : Signs.substraction),
      id: UniqueKey(),
      position: position,
      size: number.abs() >= 10
          ? Offset(gs.wUnit * 4, gs.hUnit * 2)
          : Offset(gs.wUnit * 2, gs.hUnit * 2),
      opacity: opacity ?? 1,
      radius: 5,
      textKey: UniqueKey(),
    );
  }

  static SignState generateSignState(
      {required Signs sign,
      required Offset position,
      double? opacity,
      required GameSize gs}) {
    return SignState(
      value: sign,
      id: UniqueKey(),
      position: position,
      size: Offset(gs.wUnit * 1.5, gs.hUnit * 2),
      opacity: opacity ?? 1,
      radius: 5,
    );
  }

  static ShadowNumberState generateShadowNumberState(
      String value, Offset position, GameSize gs) {
    return ShadowNumberState(
      value: value,
      id: UniqueKey(),
      position: position,
      size: Offset(gs.wUnit * 2, gs.hUnit * 2),
      opacity: 1,
      radius: 5,
    );
  }
}
