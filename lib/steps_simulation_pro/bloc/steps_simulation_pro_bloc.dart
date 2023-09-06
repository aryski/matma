import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_cubit.dart';
import 'package:matma/steps_simulation_pro/items/arrow/cubit/arrow_state.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_cubit.dart';
import 'package:matma/steps_simulation_pro/items/floor/%20cubit/floor_state.dart';
import 'package:matma/steps_simulation_pro/items/simulation_item/cubit/simulation_item_cubit.dart';

part 'steps_simulation_pro_event.dart';
part 'steps_simulation_pro_state.dart';

UniqueKey? hoverKepper;

class StepsSimulationProBloc
    extends Bloc<StepsSimulationProEvent, StepsSimulationProState> {
  final double hUnit;
  final double wUnit;
  final int hUnits;
  final int wUnits;

  StepsSimulationProBloc(
      List<int> init, this.hUnit, this.wUnit, this.hUnits, this.wUnits)
      : super(StepsSimulationProState(
            hUnit: hUnit, wUnit: wUnit, hUnits: hUnits, wUnits: wUnits)) {
    state.initializeItemsList(init);
    on<StepsSimulationProEventScroll>((event, emit) {
      scrollHandler(event);
    });
  }

  void scrollHandler(StepsSimulationProEventScroll event) {
    var item =
        state.items.firstWhere((element) => element.state.id == event.id);
    if (item is FloorCubit) {
      item.updateSize(Offset(event.dy, 0));
    }
    // event.id;
    // event.dy;
  }
}
