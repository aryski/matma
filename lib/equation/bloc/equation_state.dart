part of 'equation_bloc.dart';

class NumberItem {
  final SignCubit? sign;
  final ValueCubit value;

  NumberItem({required this.sign, required this.value});

  double get width =>
      value.state.size.value.dx +
      ((sign != null) ? sign!.state.size.value.dx : 0);

  Offset get position => ((sign != null)
      ? sign!.state.position.value
      : value.state.position.value);
}

class EquationState {
  final List<NumberItem> items;
  final List<GameItemCubit> extraItems;
  final List<NumberItem> fixedItems;
  final List<GameItemCubit> fixedExtraItems;

  EquationState(
      {this.items = const [],
      this.extraItems = const [],
      this.fixedItems = const [],
      this.fixedExtraItems = const []}) {
    updateFixedBoard();
  }

  List<int> get numbers {
    List<int> result = [];
    for (var item in items) {
      var sign = item.sign;
      var number = item.value;
      if (sign != null && sign.state.value == Signs.substraction) {
        result.add(-1 * number.state.value);
      } else {
        result.add(number.state.value);
      }
    }
    return result;
  }

  int? validateInd(int numberIndex) {
    if (numberIndex < items.length) {
      return numberIndex;
    } else {
      return null;
    }
  }

  NumberItem? getItem(int numberInd) {
    var ind = validateInd(numberInd);
    return (ind != null) ? items[ind] : null;
  }

  void updateFixedBoard() {
    for (int i = 0; i < fixedItems.length && i < items.length; i++) {
      var fixedNumberState = fixedItems[i].value.state;
      var numberState = items[i].value.state;
      if (fixedNumberState.value == numberState.value &&
          fixedNumberState.sign == numberState.sign) {
        if (fixedItems[i].value.state.withDarkenedColor) {
          fixedItems[i].value.updateWithDarkenedColor(false);
        }
      } else if (!fixedItems[i].value.state.withDarkenedColor) {
        fixedItems[i].value.updateWithDarkenedColor(true);
      }
    }
  }

  EquationState copyWith({
    List<NumberItem>? items,
    List<GameItemCubit>? extraItems,
    List<NumberItem>? fixedItems,
    List<GameItemCubit>? fixedExtraItems,
  }) {
    return EquationState(
      items: items ?? this.items,
      extraItems: extraItems ?? this.extraItems,
      fixedItems: fixedItems ?? this.fixedItems,
      fixedExtraItems: fixedExtraItems ?? this.fixedExtraItems,
    );
  }
}
