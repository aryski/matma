import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/equation/bloc/bloc_ext/number_with_sign_insertor.dart';

import 'package:matma/equation/bloc/bloc_ext/resetter.dart';
import 'package:matma/equation/bloc/bloc_ext/resizer.dart';
import 'package:matma/equation/bloc/bloc_ext/remover.dart';
import 'package:matma/equation/bloc/bloc_ext/value_updater.dart';
import 'package:matma/equation/items/number/cubit/number_cubit.dart';
import 'package:matma/equation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/quests/cubit/quests_cubit.dart';

part 'equation_event.dart';
part 'equation_state.dart';

class EquationBloc extends Bloc<EquationEvent, EquationState> {
  //TODO modify so it supports targetValues
  //add to display settings second color in case someone wants to use the support colors?
  //but ideally support colors are enums and decided in presentation;

  final EquationState init;
  final SimulationSize simSize;
  final List<int>? targetValues;
  // final QuestsCubit taskCubit;
  EquationBloc(
      {required this.init,
      required this.simSize,
      required List<int> initNumbers,
      this.targetValues})
      : super(Resetter.hardResetState(initNumbers, simSize)) {
    on<EquationEventJoinNumbers>((event, emit) {
      event.leftInd;
      event.rightInd;
      var leftItemInd = state.itemIndex(event.leftInd);
      var rightItemInd = state.itemIndex(event.rightInd);
      if (leftItemInd != null && rightItemInd != null) {
        var leftItem = state.items[leftItemInd];
        var rightItem = state.items[rightItemInd];
        if (leftItem is NumberCubit && rightItem is NumberCubit) {
          leftItem.updateValue(leftItem.state.value + rightItem.state.value);
          var rightSignInd = rightItemInd - 1;
          var rightSignItem = state.items[rightSignInd];
          if (rightSignItem is SignCubit) {
            removeWithPositionUpdate(rightSignItem);
          }
          removeWithPositionUpdate(rightItem);
          adjust();
          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      }
    });
    on<EquationEventAddNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(state.numbers.length - 1);
        if (itemInd != null) {
          insertNumberWithSignAfterInd(event.value, itemInd);
          adjust();
          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      },
    );
    on<EquationEventSplitNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(event.ind);
        if (itemInd != null) {
          var cubit = state.items[itemInd];
          if (cubit is NumberCubit) {
            cubit.updateValue(event.leftValue.abs());
          }
          insertNumberWithSignAfterInd(event.rightValue, itemInd);
        }
        adjust();
        emit(EquationState(items: state.items, extraItems: state.extraItems));
      },
    );
    on<EquationEventIncreaseNumber>((event, emit) async {
      var itemInd = state.itemIndex(event.ind);
      if (itemInd != null) {
        var cubit = state.items[itemInd];
        if (cubit is NumberCubit) {
          cubit.updateValue(cubit.state.value + 1);
          if (cubit.state.value == 10) {
            resize(itemInd, simSize.wRatio * 2);
          }
          updateValue(cubit, 1);
          adjust();
          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      }
    });
    on<EquationEventNumbersReduction>((event, emit) async {
      var itemIndLeft = state.itemIndex(event.indLeft);
      var itemIndRight = state.itemIndex(event.indRight);
      if (itemIndLeft != null && itemIndRight != null) {
        var leftCubit = state.items[itemIndLeft];
        var rightCubit = state.items[itemIndRight];
        if (leftCubit is NumberCubit && rightCubit is NumberCubit) {
          List<SimulationItemCubit> toRemove = [];
          decreaseValue(leftCubit, itemIndLeft);
          decreaseValue(rightCubit, itemIndRight);
          toRemove.addAll(lookForZeros(leftCubit, itemIndLeft));
          toRemove.addAll(lookForZeros(rightCubit, itemIndRight));
          for (var item in toRemove) {
            removeWithPositionUpdate(item);
          }
          updateValue(leftCubit, -1);
          updateValue(rightCubit, -1);

          if (state.items.isNotEmpty &&
              state.items.first is SignCubit &&
              (state.items.first as SignCubit).state.value == Signs.addition) {
            removeWithPositionUpdate(state.items.first);
          }
          adjust();
          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      }
    });
  }

  void adjust() {
    // print("present ${this.hashCode} with $target");
    // print(target);
    // if (target != null) {
    //   print("target");
    //   int j = 0;
    //   var lastCubit;
    //   for (int i = 0; i < state.items.length; i++) {
    //     var cubit = state.items[i];
    //     if (cubit is NumberCubit) {
    //       print("XDD");
    //       cubit.state.color = Colors.indigoAccent;
    //     }
    //   }
    //   for (int i = 0; i < state.items.length && j < target!.length; i++) {
    //     var cubit = state.items[i];
    //     if (cubit is NumberCubit) {
    //       var value = cubit.state.value;
    //       if (lastCubit is SignCubit &&
    //           lastCubit.state.value == Signs.substraction) {
    //         value *= -1;
    //       }
    //       if (value == target![j]) {
    //         print("indigo");
    //         cubit.state.color = cubit.state.defColor;
    //       }
    //       j++;
    //     }
    //     lastCubit = cubit;
    //   }
    // }
  }

  void decreaseValue(NumberCubit cubit, int itemInd) {
    if (cubit.state.value == 10) {
      resize(itemInd, -simSize.wRatio * 2);
    }
    cubit.updateValue(cubit.state.value - 1);
  }

  List<SimulationItemCubit> lookForZeros(NumberCubit cubit, int itemInd) {
    List<SimulationItemCubit> toRemove = [];
    if (cubit.state.value == 0) {
      if (itemInd - 1 >= 0 && itemInd - 1 < state.items.length) {
        var item = state.items[itemInd - 1];
        if (item is SignCubit) {
          toRemove.add(item);
        }
      }
      toRemove.add(cubit);
    }
    return toRemove;
  }
}
