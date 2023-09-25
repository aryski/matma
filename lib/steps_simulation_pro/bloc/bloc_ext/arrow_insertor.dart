import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matma/board_simulation/bloc/equation_board_bloc.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/scroll_handler.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_state.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';

extension ArrowInsertor on StepsSimulationProBloc {
  Future<void> handleArrowInsertion(StepsSimulationProEventPointerUp event,
      Emitter<StepsSimulationProState> emit, EquationBoardBloc board) async {
    var item = state.getItem(event.id);
    if (item is ArrowCubit) {
      item.updateHeight(3 * simSize.hUnit / 2);
      if (item.state.direction == Direction.down) {
        state.moveAllSince(item, Offset(0, 3 * simSize.hUnit / 2));
      } else {
        state.moveAllSinceIncluded(item, Offset(0, -simSize.hUnit * 3 / 2));
      }

      await Future.delayed(const Duration(milliseconds: 200));
      var inserted = _insertArrow(item, item.state.direction);

      //tutaj trzeba sie dowiedziec ktora to liczba XD
      //todo zmienic architekture tak zeby nie bylo itemsow tylko klasy liczb z itemsami
      //czyli de facto dochodzimy do gramatyki, w ktorej mamy
      //(wyrazenie) -  wyrazenie
      // board.add(EquationBoardEventIncreaseNumber(ind: ));
      emit(state.copy());
      await Future.delayed(const Duration(milliseconds: 20));
      //TODO

      //animate scroll
      if (inserted[0] is ArrowCubit) {
        (inserted[0] as ArrowCubit).animate(1);
      }

      var delta = simSize.wUnit;
      if (inserted[1] is FloorCubit) {
        (inserted[1] as FloorCubit).updateSize(Offset(delta, 0));
        state.moveAllSince(inserted[1], Offset(delta, 0));
      }
    }
  }

  List<SimulationItemCubit> _insertArrow(
      SimulationItemCubit<SimulationItemState> item, Direction direction) {
    var currentLeft = item.state.position.dx;
    var currentTop = item.state.position.dy;
    var pos = Offset(currentLeft, currentTop);
    late SimulationItemCubit arrow1;
    late SimulationItemCubit arrow2;
    late SimulationItemCubit floor;
    if (direction == Direction.up) {
      arrow1 = generateArrowUp(
          position: pos, delta: Offset(0, simSize.hUnit), animationProgress: 0);
      arrow2 = generateArrowUp(position: pos, delta: Offset.zero);
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit),
          widthRatio: 0.25);
    } else {
      arrow1 = generateArrowDown(
          position: pos, delta: Offset.zero, animationProgress: 0);
      arrow2 =
          generateArrowDown(position: pos, delta: Offset(0, simSize.hUnit));
      floor = generateFloor(
          position: pos,
          delta: Offset(simSize.wUnit / 2, simSize.hUnit - simSize.hUnit / 7),
          widthRatio: 0.25);
    }
    for (int i = 0; i < state.numbers.length; i++) {
      var number = state.numbers[i];
      if (number.items.contains(item)) {
        for (int j = 0; j < number.items.length; j++) {
          if (number.items[j] == item) {
            number.items.replaceRange(j, j + 1, [arrow1, floor, arrow2]);
            number.expand();
            board.add(EquationBoardEventIncreaseNumber(ind: i));
            break;
          }
        }
      }
    }

    return [arrow1, floor, arrow2];
  }
}
