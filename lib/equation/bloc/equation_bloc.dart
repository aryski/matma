import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/number_with_sign_insertor.dart';

import 'package:matma/equation/bloc/bloc_ext/resetter.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/bloc_ext/remover.dart';
import 'package:matma/equation/bloc/bloc_ext/reducer.dart';
import 'package:matma/equation/bloc/bloc_ext/shadow_numbers_generator.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/game_item/cubit/game_item_cubit.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';

part 'equation_event.dart';
part 'equation_state.dart';

class EquationBloc extends Bloc<EquationEvent, EquationState> {
  final EquationState init;
  final GameSize gs;
  final List<int>? targetValues;
  EquationBloc(
      {required this.init,
      required this.gs,
      required List<int> initNumbers,
      this.targetValues})
      : super(Resetter.hardResetState(initNumbers, gs, targetValues)) {
    on<EquationEventIncreaseNumber>((event, emit) async {
      var itemInd = state.itemIndex(event.ind);
      if (itemInd != null) {
        var item = state.items[itemInd];
        item.number.updateValue(item.number.state.value + 1);
        if (item.number.state.value == 10) {
          resize(item, gs.wUnit * 2);
        }
        generateShadowNumbers(item, 1);
        updateFixedItemsColors(state);
        emit(EquationState(
            items: state.items,
            extraItems: state.extraItems,
            fixedItems: state.fixedItems,
            fixedExtraItems: state.fixedExtraItems));
      }
    });
    on<EquationEventJoinNumbers>((event, emit) {
      var leftItemInd = state.itemIndex(event.leftInd);
      var rightItemInd = state.itemIndex(event.rightInd);
      if (leftItemInd != null && rightItemInd != null) {
        var leftItem = state.items[leftItemInd];
        var rightItem = state.items[rightItemInd];
        leftItem.number.updateValue(
            leftItem.number.state.value + rightItem.number.state.value);
        removeEquationDefaultItemWithPositionUpdate(rightItem);
        updateFixedItemsColors(state);
        emit(EquationState(
            items: state.items,
            extraItems: state.extraItems,
            fixedItems: state.fixedItems,
            fixedExtraItems: state.fixedExtraItems));
      }
    });
    on<EquationEventAddNumber>(
      (event, emit) {
        if (state.items.isNotEmpty) {
          insertNumberWithSignAfterItem(event.value, state.items.last);
          updateFixedItemsColors(state);
          emit(EquationState(
              items: state.items,
              extraItems: state.extraItems,
              fixedItems: state.fixedItems,
              fixedExtraItems: state.fixedExtraItems));
        }
      },
    );
    on<EquationEventSplitNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(event.ind);
        if (itemInd != null) {
          var item = state.items[itemInd];
          item.number.updateValue(event.leftValue.abs());
          insertNumberWithSignAfterItem(event.rightValue, item);
        }
        updateFixedItemsColors(state);
        emit(EquationState(
            items: state.items,
            extraItems: state.extraItems,
            fixedItems: state.fixedItems,
            fixedExtraItems: state.fixedExtraItems));
      },
    );
    on<EquationEventNumbersReduction>((event, emit) async {
      var itemIndLeft = state.itemIndex(event.indLeft);
      var itemIndRight = state.itemIndex(event.indRight);
      if (itemIndLeft != null && itemIndRight != null) {
        var leftItem = state.items[itemIndLeft];
        var rightItem = state.items[itemIndRight];
        reduce(leftItem, rightItem);
        updateFixedItemsColors(state);
        emit(EquationState(
            items: state.items,
            extraItems: state.extraItems,
            fixedItems: state.fixedItems,
            fixedExtraItems: state.fixedExtraItems));
      }
    });
  }

  void decreaseValue(EquationDefaultItem myItem) {
    var number = myItem.number;
    if (number.state.value == 10) {
      resize(myItem, -gs.wUnit * 2);
    }
    number.updateValue(number.state.value - 1);
  }

  void updateFixedItemsColors(EquationState state) {
    for (int i = 0;
        i < state.fixedItems.length && i < state.items.length;
        i++) {
      var fixedNumberState = state.fixedItems[i].number.state;
      var numberState = state.items[i].number.state;
      if (fixedNumberState.value != numberState.value &&
          fixedNumberState.sign == numberState.sign) {
        state.fixedItems[i].number.updateWithDarkenedColor(
            fixedNumberState.withDarkenedColor ? false : true);
      }
    }
  }
}
