part of 'package:matma/equation/bloc/equation_bloc.dart';

extension BoardItemsGenerator on EquationBloc {
  static BoardState generateBoardState(
      {required Offset position, required Offset size}) {
    return BoardState(
        id: UniqueKey(),
        position: AnimatedProp.zero(value: position),
        size: AnimatedProp.zero(value: size),
        opacity: AnimatedProp.zero(value: 1.0),
        radius: constants.boardRadius);
  }

  static NumberState generateNumberState(
      {required int number,
      required Offset position,
      double? opacity,
      bool? isInactive,
      bool withDarkenedColor = false}) {
    return NumberState(
      withDarkenedColor: withDarkenedColor,
      value: number.abs(),
      sign: ((number > 0) ? Signs.addition : Signs.substraction),
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(
          value:
              constants.numberRatio.scale(((number.abs() >= 10) ? 2 : 1), 1)),
      opacity: AnimatedProp.zero(value: opacity ?? 1.0),
      radius: constants.numberRadius,
      textKey: UniqueKey(),
    );
  }

  static SignState generateSignState(
      {required Signs sign, required Offset position, double? opacity}) {
    return SignState(
      value: sign,
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(value: constants.signRatio),
      opacity: AnimatedProp.zero(value: opacity ?? 1.0),
      radius: constants.numberRadius,
    );
  }

  static ShadowNumberState generateShadowNumberState(
      String value, Offset position) {
    return ShadowNumberState(
      value: value,
      id: UniqueKey(),
      position: AnimatedProp.zero(value: position),
      size: AnimatedProp.zero(value: constants.numberRatio),
      opacity: AnimatedProp.zero(value: 1.0),
      radius: constants.numberRadius,
    );
  }

  Future<void> generateShadowNumbers(
      EquationDefaultItem item, int delta) async {
    if (state.items.contains(item)) {
      var sign = Signs.substraction;
      if (item.sign != null) {
        if (item.sign!.state.value == Signs.substraction) {
          sign = Signs.addition;
        }
      }
      var shadowCubit = ShadowNumberCubit(
          BoardItemsGenerator.generateShadowNumberState(
              sign == Signs.addition ? "+1" : "−1",
              item.number.state.position.value + Offset(15, 45.0)));
      state.extraItems.add(shadowCubit);
      shadowCubit.updatePosition(Offset(0, constants.numberRatio.dy / 2),
          delayInMillis: 20, milliseconds: 1000);
    }
  }
}
