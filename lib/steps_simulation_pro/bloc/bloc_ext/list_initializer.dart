import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/bloc/bloc_ext/items_generator.dart';
import 'package:matma/steps_simulation_pro/bloc/steps_simulation_pro_bloc.dart';
import 'package:matma/common/items/simulation_item/cubit/simulation_item_cubit.dart';

extension Initializer on StepsSimulationProBloc {
  List<SimulationItemCubit> initializeItemsList() {
    final List<SimulationItemCubit> items = [];
    List<int> init = board.state.numbers;
    var currentTop = (simSize.hUnits / 2).ceil() * simSize.hUnit;
    var currentLeft = simSize.wUnit * 3;
    for (var element in init) {
      if (element > 0) {
        for (int i = 0; i < element; i++) {
          var pos = Offset(currentLeft, currentTop);
          items.add(generateArrowUp(position: pos, delta: Offset.zero));
          items.add(generateFloor(
              position: pos, delta: Offset(simSize.wUnit / 2, 0)));

          currentTop -= simSize.hUnit;
          currentLeft += simSize.wUnit;
        }
      } else {
        for (int i = 0; i > element; i--) {
          var pos = Offset(currentLeft, currentTop);
          items.add(generateArrowDown(
              position: pos,
              delta: Offset(0, simSize.hUnit + simSize.hUnit / 7)));
          items.add(generateFloor(
              position: pos,
              delta: Offset(simSize.wUnit / 2, 2 * simSize.hUnit)));

          currentTop += simSize.hUnit;
          currentLeft += simSize.wUnit;
        }
      }
    }
    return items;
  }
}
