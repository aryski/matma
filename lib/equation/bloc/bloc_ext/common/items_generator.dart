part of 'package:matma/equation/bloc/equation_bloc.dart';

extension BoardItemsGenerator on EquationBloc {
  static BoardState genBoardState(
      {required Offset position, required Offset size}) {
    return BoardState(
        id: UniqueKey(),
        position: AnimatedProp.zero(value: position),
        size: AnimatedProp.zero(value: size),
        opacity: AnimatedProp.zero(value: 1.0));
  }

  static ValueState genValueState(
      {required int number,
      required Offset position,
      double? opacity,
      bool? isInactive,
      bool withDarkenedColor = false}) {
    return ValueState(
      withDarkenedColor: withDarkenedColor,
      value: number.abs(),
      sign: ((number > 0) ? Signs.addition : Signs.substraction),
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(
          value: constants.numberRatio
              .scale(number.abs().toString().length.toDouble(), 1)),
      opacity: AnimatedProp.zero(value: opacity ?? 1.0),
      switcherKey: UniqueKey(),
    );
  }

  static SignState genSignState(
      {required Signs sign, required Offset position, double? opacity}) {
    return SignState(
      switcherKey: UniqueKey(),
      value: sign,
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(value: constants.signRatio),
      opacity: AnimatedProp.zero(value: opacity ?? 1.0),
    );
  }

  static ShadowNumberState genShadowNumberState(String value, Offset position) {
    return ShadowNumberState(
      value: value,
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(value: constants.numberRatio),
      opacity: AnimatedProp.zero(value: 1.0),
    );
  }
}
