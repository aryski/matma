import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/number_with_sign_insertor.dart';

import 'package:matma/board_simulation/bloc/bloc_ext/update_handler.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/resizer.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/remover.dart';
import 'package:matma/board_simulation/items/number/cubit/number_cubit.dart';
import 'package:matma/board_simulation/items/shadow_number/cubit/shadow_number_cubit.dart';
import 'package:matma/board_simulation/items/sign/cubit/sign_cubit.dart';
import 'package:matma/common/colors.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/steps_simulation/bloc/steps_simulation_bloc.dart';

part 'equation_board_event.dart';
part 'equation_board_state.dart';

class EquationBoardBloc extends Bloc<EquationBoardEvent, EquationBoardState> {
  final EquationBoardState init;
  final SimulationSize simSize;
  EquationBoardBloc(
      {required this.init,
      required this.simSize,
      required List<int> initNumbers})
      : super(UpdateHandler.hardResetState(initNumbers, simSize)) {
    on<EquationBoardEventJoinNumbers>((event, emit) {
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

          emit(EquationBoardState(
              items: state.items, extraItems: state.extraItems));
        }
      }
    });
    on<EquationBoardEventAddNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(state.numbers.length - 1);
        if (itemInd != null) {
          insertNumberWithSignAfterInd(event.value, itemInd);
          emit(EquationBoardState(
              items: state.items, extraItems: state.extraItems));
        }
      },
    );
    on<EquationBoardEventSplitNumber>(
      (event, emit) {
        var itemInd = state.itemIndex(event.ind);
        if (itemInd != null) {
          var cubit = state.items[itemInd];
          if (cubit is NumberCubit) {
            cubit.updateValue(event.leftValue.abs());
          }
          insertNumberWithSignAfterInd(event.rightValue, itemInd);
        }

        emit(EquationBoardState(
            items: state.items, extraItems: state.extraItems));
      },
    );
    on<EquationBoardEventIncreaseNumber>((event, emit) async {
      var itemInd = state.itemIndex(event.ind);
      if (itemInd != null) {
        var cubit = state.items[itemInd];
        if (cubit is NumberCubit) {
          cubit.updateValue(cubit.state.value + 1); //updated value
          //resizing for bigger numbers
          if (cubit.state.value == 10) {
            resize(itemInd, simSize.wUnit * 2);
          }
          updateValue(cubit, 1);

          emit(EquationBoardState(
              items: state.items, extraItems: state.extraItems));
        }
      }
    });
    on<EquationBoardEventNumbersReduction>((event, emit) async {
      var itemIndLeft = state.itemIndex(event.indLeft);
      var itemIndRight = state.itemIndex(event.indRight);
      print("merge: ${event.indLeft} ${event.indRight}");
      print("merge: $itemIndLeft $itemIndRight");

      if (itemIndLeft != null && itemIndRight != null) {
        var leftCubit = state.items[itemIndLeft];
        var rightCubit = state.items[itemIndRight];
        if (leftCubit is NumberCubit && rightCubit is NumberCubit) {
          if (leftCubit.state.value == 10) {
            resize(itemIndLeft, -simSize.wUnit * 2);
          }
          if (rightCubit.state.value == 10) {
            resize(itemIndRight, -simSize.wUnit * 2);
          }
          leftCubit.updateValue(leftCubit.state.value - 1);
          rightCubit.updateValue(rightCubit.state.value - 1);

          List<SimulationItemCubit> toRemove = [];
          if (leftCubit.state.value == 0) {
            //update pozycji
            if (itemIndLeft - 1 >= 0 && itemIndLeft - 1 < state.items.length) {
              var item = state.items[itemIndLeft - 1];
              if (item is SignCubit) {
                toRemove.add(item);
              }
            }
            toRemove.add(leftCubit);
          }
          if (rightCubit.state.value == 0) {
            if (itemIndRight - 1 >= 0 &&
                itemIndRight - 1 < state.items.length) {
              var item = state.items[itemIndRight - 1];
              if (item is SignCubit) {
                toRemove.add(item);
              }
            }
            toRemove.add(rightCubit);
          }
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
          emit(EquationBoardState(
              items: state.items, extraItems: state.extraItems));
        }
      }
      event.indRight;
    });
  }
}

extension ItemsGenerator on EquationBoardBloc {
  NumberState generateNumberState(
      {required int number, required Offset position, double? opacity}) {
    // assert(number >= 0);
    return NumberState(
        value: number.abs(),
        color: number > 0 ? defaultGreen : defaultRed,
        defColor: defaultYellow,
        hovColor: defaultYellow,
        id: UniqueKey(),
        position: position,
        size: number.abs() >= 10
            ? Offset(simSize.wUnit * 4, simSize.hUnit * 2)
            : Offset(simSize.wUnit * 2, simSize.hUnit * 2),
        opacity: opacity ?? 1,
        radius: 5,
        textKey: UniqueKey());
  }

  ShadowNumberState generateShadowNumberState(
      String value, Offset position, SimulationSize simSize) {
    return ShadowNumberState(
      value: value,
      color: defaultGrey,
      defColor: defaultGrey,
      hovColor: defaultGrey,
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wUnit * 2, simSize.hUnit * 2),
      opacity: 1,
      radius: 5,
    );
  }

  SignState generateSignState(
      {required Signs sign, required Offset position, double? opacity}) {
    return SignState(
      value: sign,
      color: Colors.white,
      defColor: defaultYellow,
      hovColor: defaultYellow,
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wUnit * 1.5, simSize.hUnit * 2),
      opacity: opacity ?? 1,
      radius: 5,
    );
  }
}
