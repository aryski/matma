part of 'equation_bloc.dart';

class EquationDefaultItem {
  final SignCubit? sign;
  final NumberCubit number;

  EquationDefaultItem({required this.sign, required this.number});

  double get width =>
      number.state.size.value.dx +
      ((sign != null) ? sign!.state.size.value.dx : 0);

  Offset get position => ((sign != null)
      ? sign!.state.position.value
      : number.state.position.value);
}

class EquationState {
  final List<EquationDefaultItem> items;
  final List<GameItemCubit> extraItems;
  final List<EquationDefaultItem> fixedItems;
  final List<GameItemCubit> fixedExtraItems;

  EquationState(
      {this.items = const [],
      this.extraItems = const [],
      this.fixedItems = const [],
      this.fixedExtraItems = const []});

  List<int> get numbers => genNum();

  Signs getNumberSign(NumberCubit number) {
    for (var item in items) {
      if (item.number == number) {
        if (item.sign != null) {
          return item.sign!.state.value;
        } else {
          return Signs.addition;
        }
      }
    }
    return Signs.addition;
  }

  List<int> genNum() {
    List<int> result = [];
    for (var item in items) {
      var sign = item.sign;
      var number = item.number;
      if (sign != null && sign.state.value == Signs.substraction) {
        result.add(-1 * number.state.value);
      } else {
        result.add(number.state.value);
      }
    }
    return result;
  }

  int? itemIndex(int numberIndex) {
    if (numberIndex < items.length) {
      return numberIndex;
    } else {
      return null;
    }
  }
}
