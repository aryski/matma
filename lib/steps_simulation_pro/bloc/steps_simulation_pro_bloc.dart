import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
      : super(StepsSimulationProState()) {
    state.initializeItemsList(init);
    on<StepsSimulationProEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
