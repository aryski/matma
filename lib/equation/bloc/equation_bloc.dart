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
import 'package:matma/levels/level/cubit/level_cubit.dart';
import 'package:matma/steps_game/bloc/steps_game_bloc.dart';
import 'package:matma/task_simulation/cubit/task_simulation_cubit.dart';

part 'equation_event.dart';
part 'equation_state.dart';

class EquationBloc extends Bloc<EquationEvent, EquationState> {
  final EquationState init;
  final SimulationSize simSize;
  final TaskSimulationCubit taskCubit;
  EquationBloc(
      {required this.taskCubit,
      required this.init,
      required this.simSize,
      required List<int> initNumbers})
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

          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      }
    });
    on<EquationEventAddNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(state.numbers.length - 1);
        if (itemInd != null) {
          insertNumberWithSignAfterInd(event.value, itemInd);
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
          emit(EquationState(items: state.items, extraItems: state.extraItems));
        }
      }
      event.indRight;
    });
  }

  @override
  void onChange(Change<EquationState> change) {
    super.onChange(change);
    taskCubit.equationValue(change.nextState.numbers);
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
