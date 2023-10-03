import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:matma/board_simulation/bloc/bloc_ext/update_handler.dart';
import 'package:matma/board_simulation/bloc/bloc_ext/resizer.dart';
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
        // var itemInd = state.itemIndex(event.ind);

        var itemInd = state.itemIndex(state.numbers.length - 1);
        if (itemInd != null) {
          var cubit = state.items[itemInd];
          state.items.insert(
              itemInd + 1,
              NumberCubit(
                generateNumberState(
                    event.value.abs(),
                    Offset(cubit.state.position.dx + cubit.state.size.dx,
                        cubit.state.position.dy)),
              ));
          spread(itemInd + 1, state.items[itemInd + 1].state.size.dx);
          state.items.insert(
              itemInd + 1,
              SignCubit(
                generateSignState(
                    event.value > 0 ? Signs.addition : Signs.substraction,
                    Offset(cubit.state.position.dx + cubit.state.size.dx,
                        cubit.state.position.dy)),
              ));
          spread(itemInd + 1, state.items[itemInd + 1].state.size.dx);

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
          print("split!");
          //generowanie pustego ziomeczka ktory sie wyswietla jako pusty
          // a potem jego update????
          //ciezko powiedziec TODOo
          state.items.insert(
              itemInd + 1,
              generateAnimatedNumberCubit(
                  event.rightValue.abs(),
                  Offset(cubit.state.position.dx + cubit.state.size.dx,
                      cubit.state.position.dy))
              // NumberCubit(
              //   generateNumberState(
              //       event.rightValue.abs(),
              //       Offset(cubit.state.position.dx + cubit.state.size.dx,
              //           cubit.state.position.dy)),
              // ),
              );
          spread(itemInd + 1, state.items[itemInd + 1].state.size.dx);
          state.items.insert(
            itemInd + 1,
            SignCubit(
              generateSignState(
                  event.rightValue > 0 ? Signs.addition : Signs.substraction,
                  Offset(cubit.state.position.dx + cubit.state.size.dx,
                      cubit.state.position.dy)),
            ),
          );

          spread(itemInd + 1, state.items[itemInd + 1].state.size.dx);
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

          emit(EquationBoardState(
              items: state.items, extraItems: state.extraItems));
        }
      }
      event.indRight;
    });
  }
}

extension ItemsGenerator on EquationBoardBloc {
  NumberState generateNumberState(int number, Offset position) {
    assert(number >= 0);
    return NumberState(
        value: number,
        color: defaultYellow,
        defColor: defaultYellow,
        hovColor: defaultYellow,
        id: UniqueKey(),
        position: position,
        size: number.abs() >= 10
            ? Offset(simSize.wUnit * 4, simSize.hUnit * 2)
            : Offset(simSize.wUnit * 2, simSize.hUnit * 2),
        opacity: 1,
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
    Signs sign,
    Offset position,
  ) {
    return SignState(
      value: sign,
      color: defaultYellow,
      defColor: defaultYellow,
      hovColor: defaultYellow,
      id: UniqueKey(),
      position: position,
      size: Offset(simSize.wUnit * 1.5, simSize.hUnit * 2),
      opacity: 1,
      radius: 5,
    );
  }

  NumberCubit generateAnimatedNumberCubit(int number, Offset position) {
    var result = generateNumberState(number, position);
    result.opacity = 0;
    var result2 = NumberCubit(result);
    Future.delayed(Duration(milliseconds: 20), () {
      result2.setOpacity(1);
    });
    return result2;
  }
}
