import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'stairs_simulation_event.dart';
part 'stairs_simulation_state.dart';

class StepsSimulationBloc
    extends Bloc<StepsSimulationEvent, StepsSimulationState> {
  final double hUnit;
  final double wUnit;
  final int hUnits;
  final int wUnits;
  StepsSimulationBloc(
      List<int> init, this.hUnit, this.wUnit, this.hUnits, this.wUnits)
      : super(StepsSimulationState(hUnit, wUnit, hUnits, wUnits)) {
    state.initializeStairList(init);
    on<RegisterHover>((event, emit) {
      state.updateHover(event.hover);
    });
    on<StepsSimulationClick>((event, emit) {
      // print("CLICK");
      var item = state.items.firstWhere(
        (element) => element.id == event.id,
      );
      // print(item.height);
      // item.top -= hUnit / 7;
      if (item is StepSimulationItem) {
        state.animatePreGemmation(item);
      }
      emit(state.copy());
    });

    on<StepsSimulationClickEnd>((event, emit) {
      // print("CLICK END");
      var item = state.items.firstWhere(
        (element) => element.id == event.id,
      );
      if (item is StepSimulationItem) {
        state.animateGemmation(item);
        // state.handleItemHeight(item, true);
      }
      // print(item.height);
      // item.top += hUnit / 7;
      emit(state.copy());
    });

    on<StepsSimulationRetract>((event, emit) {
      // print("CLICK END");
      var item = state.items.firstWhere(
        (element) => element.id == event.id,
      );
      if (item is StepSimulationItem) {
        state.animateGemmationRetract(item);
        // state.handleItemHeight(item, true);
      }
      // print(item.height);
      // item.top += hUnit / 7;
      emit(state.copy());
    });

    on<StepsSimulationClickAnimationDone>((event, emit) async {
      // print("CLICK END");
      var item = state.items.firstWhere(
        (element) => element.id == event.id,
      );
      if (item is StepSimulationItem) {
        var ind = state.animateGemmationDone(item);
        emit(state.copy());

        await Future.delayed(Duration(milliseconds: 1));
        state.items[ind].width = wUnit * 1.25;
        state.items[ind + 1].position += Offset(wUnit, 0);
        emit(state.copy());
        // sleep(Duration(milliseconds: 100));

        // state.handleItemHeight(item, true);
      }
      // // print(item.height);
      // // item.top += hUnit / 7;
    });
    on<StepsSimulationScroll>((event, emit) {
      state.scrollId(event.id, event.delta);

      emit(state.copy());
      // if (state.currentHover != null) {

      // }
    });
  }
}
